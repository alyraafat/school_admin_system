import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_admin_system/cubit/states.dart';
import 'package:school_admin_system/models/booking_time_model.dart';
import 'package:school_admin_system/shared/constants.dart';


class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  void changeField() {
    emit(AppChangeFieldState());
  }

  var userModel = {};
  void getUserData({
  required String uId
  }){
    emit(AppGetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      userModel = value.data()!;
      emit(AppGetUserSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetUserErrorState(error));
    });
  }

  var oneSchool = {};
  void getOneSchoolData({
    required String cityId,
    required String schoolId
  }){
    emit(AppGetOneSchoolLoadingState());
    FirebaseFirestore.instance
        .collection('cities')
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .get()
        .then((value) {
      oneSchool = value.data()!;
      emit(AppGetOneSchoolSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppGetOneSchoolErrorState(error));
    });
  }

  DateTime createLastDate(){
    var dateOfToday = DateTime.now();
    int month = dateOfToday.month;
    int year = dateOfToday.year;
    int day=dateOfToday.day;
    if(month==12) {
      month = 2;
      year++;
    } else if(month==11) {
      month = 1;
      year++;
    }else {
      month += 2;
    }
    String strDay = day.toString();
    String strMonth = month.toString();
    if(day<10) strDay = "0"+strDay;
    if(month<10) strMonth = "0"+strMonth;
    DateTime date = DateTime.parse("$year-$strMonth-$strDay");
    return date;
  }

  String dateToDay({
    required String date
  }){
    String day = "";
    int dayNumber = DateTime.parse(date).weekday;
    switch(dayNumber){
      case 1: day = "Monday";break;
      case 2: day = "Tuesday";break;
      case 3: day = "Wednesday";break;
      case 4: day = "Thursday";break;
      case 5: day = "Friday";break;
      case 6: day = "Saturday";break;
      case 7: day = "Sunday";break;
    }
    return day;
  }

  List<List<int>> timeTable =[];
  List<List<int>> createTimeTable({
    required List<dynamic> intervals
  }){
    List<List<int>> timeTable = [];
    for(int i=0;i<intervals[intervals.length-1];i++){
      for(int j=0;j<intervals.length-1;j+=2){
        var diff;
        if(intervals[j+1]>intervals[j]) {
          diff = intervals[j+1]-intervals[j];
        } else {
          diff = (intervals[j+1]+12)-(intervals[j]-12);
        }
        for(int k=0;k<diff;k++){
          if(intervals[j]+k+1==24&&intervals[j]+k==23) {
            timeTable.add([intervals[j]+k,0]);
          } else if(intervals[j]+k==24) {
            timeTable.add([0,intervals[j]+k+1-24]);
          } else if(intervals[j]+k>24) {
            timeTable.add([intervals[j]+k-24,intervals[j]+k+1-24]);
          } else {
            timeTable.add([intervals[j]+k,intervals[j]+k+1]);
          }
        };
      }
    }
    print(timeTable);
    return timeTable;
  }
  var startTimes =[];
  var selected = [];
  void checkDateInDataBase({
    required String date,
    required String cityId,
    required String schoolId,
    required String field,
    required int fees,
    required List<dynamic> intervals
  }){
    emit(AppCheckDataInDatabaseLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .orderBy("from")
        .get()
        .then((value) {
      if(value.docs.isNotEmpty) {
        getBookingTimeModel(
            cityId: cityId,
            date: date,
            schoolId: schoolId,
            field: field
        );
      }
      else {
        createBookingTimeModel(
            fees: fees,
            schoolId: schoolId,
            field: field,
            cityId: cityId,
            date: date,
            intervals: intervals
        );
      }
      emit(AppCheckDataInDatabaseSuccessState());
    }).catchError((error){
      print(error.toString);
      emit(AppCheckDataInDatabaseErrorState(error));
    });
  }

  void createBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required int fees,
    required String field,
    required List<dynamic> intervals
  }){

    timeTable = createTimeTable(intervals: intervals);
    timeTable.forEach((list){
      BookingTimeModel bookingTimeModel = BookingTimeModel(
        to: list[1],
        userId: "",
        from: list[0],
        isDone: false,
        fees: fees,
        isBooked: false,
        userPhone: '',
        userName: '',
      );
      emit(AppCreateBookingTimeLoadingState());
      FirebaseFirestore.instance
          .collection("cities")
          .doc(cityId)
          .collection("schools")
          .doc(schoolId)
          .collection("fields")
          .doc(field)
          .collection("bookingDay")
          .doc(date)
          .collection("bookingTime")
          .doc(list[0].toString())
          .set(bookingTimeModel.toMap())
          .then((value) {
        emit(AppCreateBookingTimeSuccessState());
      }
      ).catchError((error) {
        print(error.toString());
        emit(AppCreateBookingTimeErrorState(error));
      });
    });
    getBookingTimeModel(
        cityId: cityId,
        field: field,
        schoolId: schoolId,
        date: date
    );

  }

  void getBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
  }){
    startTimes = [];
    selected = [];
    emit(AppGetBookingTimeLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .orderBy("from")
        .snapshots()
        .listen((event) {
          startTimes = [];
          selected = [];
          event.docs.forEach((startTime){
            if(date==DateFormat.yMMMd().format(DateTime.now())){
              if(TimeOfDay.now().hour>=startTime.data()["from"]){
                updateBookingTimeModel(cityId: cityId, schoolId: schoolId, date: date, field: field, from: startTime.data()["from"].toString(), data: {
                  "isDone": true
                });
              }
            }
            if(!startTime.data()["isDone"]) {
              startTimes.add(startTime.data());
              selected.add(false);
            }
          });
          emit(AppGetBookingTimeSuccessState());
        });
    //     .then((value) {
    //
    // }).catchError((error) {
    //   print(error.toString());
    //   emit(AppGetBookingTimeErrorState(error));
    // }
    // );
  }

  void updateBookingTimeModel({
    required String cityId,
    required String schoolId,
    required String date,
    required String field,
    required String from,
    required Map<String,dynamic> data,
  }){
    emit(AppUpdateBookingTimeLoadingState());
    FirebaseFirestore.instance
        .collection("cities")
        .doc(cityId)
        .collection("schools")
        .doc(schoolId)
        .collection("fields")
        .doc(field)
        .collection("bookingDay")
        .doc(date)
        .collection("bookingTime")
        .doc(from)
        .update(data)
        .then((value) {
      emit(AppUpdateBookingTimeSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(AppUpdateBookingTimeErrorState(error));
    });
  }

  void changeDate() {
    emit(AppChangeDateState());
  }
  void changeRowColor() {
    emit(AppChangeRowColorState());
  }



}
