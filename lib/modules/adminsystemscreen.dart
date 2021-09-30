import 'dart:math';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:school_admin_system/modules/login/cubit/cubit.dart';
import 'package:school_admin_system/shared/components.dart';
import 'package:school_admin_system/shared/constants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AdminSystemScreen extends StatelessWidget {
  var dateController = TextEditingController();
  var fieldController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  Random random = Random();
  String day = "";
  var count = 0;
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getOneSchoolData(cityId: LoginCubit.get(context).adminModel["cityId"], schoolId: LoginCubit.get(context).adminModel["schoolId"]);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Admin System',
                style: TextStyle(
                    color: Color(0xff388E3C),
                    fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
            body:Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                   Text(
                  '${cubit.oneSchool["name"]}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                          itemBuilder: (context , index) => Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)
                            ),
                            color: (cubit.currentIndex == index)?defaultColor: Colors.grey[300] ,
                            child: defaultTextButton(
                                text: "Field ${index+1}",
                                function: () {
                                  cubit.currentIndex = index;
                                  cubit.changeField();
                                  if(cubit.oneSchool["calendar${cubit.currentIndex+1}"][day].length != 1) {
                                    AppCubit.get(context).checkDateInDataBase(date: dateController.text, cityId: LoginCubit.get(context).adminModel["cityId"], schoolId: LoginCubit.get(context).adminModel["schoolId"], field: (cubit.currentIndex+1).toString(), fees: cubit.oneSchool["fees"],intervals:cubit.oneSchool["calendar${cubit.currentIndex+1}"][day]);
                                  }
                                },
                                color: (cubit.currentIndex == index)?Colors.white: defaultColor ,
                            ),
                          ),
                          separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          itemCount: cubit.oneSchool["fields"]==null?0:cubit.oneSchool["fields"]
                      ),
                    ),
                const SizedBox(height:15),
                defaultFormField(
                    controller: dateController,
                    prefix: Icons.date_range,
                    text: 'Choose a Date',
                    onTap: () {
                      // showDatePicker(
                      //   context: context,
                      //   initialDate: DateTime.now(),
                      //   firstDate: DateTime.now(),
                      //   lastDate: DateTime.parse('2030-05-03'),
                      // ).then((value) {
                      //   dateController.text =
                      //       DateFormat.yMMMd().format(value!);
                      showRoundedDatePicker(
                          firstDate: AppCubit.get(context).createFirstDate(),
                          lastDate: AppCubit.get(context).createLastDate(),
                          context: context,
                          // theme: ThemeData(primarySwatch: Colors.deepPurple),
                          styleDatePicker: MaterialRoundedDatePickerStyle(
                            textStyleDayButton:
                            const TextStyle(fontSize: 36, color: Colors.white),
                            textStyleYearButton: const TextStyle(
                              fontSize: 52,
                              color: Colors.white,
                            ),
                            textStyleDayHeader: const TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                            textStyleCurrentDayOnCalendar: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textStyleDayOnCalendar:
                            const TextStyle(fontSize: 28, color: Colors.white),
                            textStyleDayOnCalendarSelected: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textStyleDayOnCalendarDisabled: TextStyle(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.1)),
                            textStyleMonthYearHeader: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            paddingDatePicker: const EdgeInsets.all(0),
                            paddingMonthHeader: const EdgeInsets.all(32),
                            paddingActionBar: const EdgeInsets.all(16),
                            paddingDateYearHeader: const EdgeInsets.all(32),
                            sizeArrow: 50,
                            colorArrowNext: Colors.white,
                            colorArrowPrevious: Colors.white,
                            marginLeftArrowPrevious: 16,
                            marginTopArrowPrevious: 16,
                            marginTopArrowNext: 16,
                            marginRightArrowNext: 32,
                            textStyleButtonAction:
                            const TextStyle(fontSize: 28, color: Colors.white),
                            textStyleButtonPositive: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textStyleButtonNegative: TextStyle(
                                fontSize: 28,
                                color: Colors.white.withOpacity(0.5)),
                            decorationDateSelected: BoxDecoration(
                                color: Colors.orange[600],
                                shape: BoxShape.circle),
                            backgroundPicker: defaultColor,
                            backgroundActionBar: defaultColor,
                            backgroundHeaderMonth: defaultColor,
                          ),
                          styleYearPicker: MaterialRoundedYearPickerStyle(
                            textStyleYear:
                            const TextStyle(fontSize: 40, color: Colors.white),
                            textStyleYearSelected: const TextStyle(
                                fontSize: 56,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            heightYearRow: 100,
                            backgroundPicker: defaultColor,
                          )).then((value) {
                            day = AppCubit.get(context).dateToDay(date: value.toString());
                            dateController.text = DateFormat("yyyy-MM-dd").format(value!);
                            if(cubit.oneSchool["calendar${cubit.currentIndex+1}"][day].length != 1) {
                              AppCubit.get(context).checkDateInDataBase(
                                  date: dateController.text,
                                  cityId: LoginCubit.get(context).adminModel["cityId"],
                                  schoolId: LoginCubit.get(context).adminModel["schoolId"],
                                  field: (cubit.currentIndex+1).toString(),
                                  fees: cubit.oneSchool["fees"],
                                  intervals:cubit.oneSchool["calendar${cubit.currentIndex+1}"][day]);
                            }
                            AppCubit.get(context).changeDate();
                      });
                    }),
                    Container(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                ListView.separated(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index)
                                    {
                                      int from  = cubit.startTimes[index]["from"];
                                      int to = cubit.startTimes[index]["to"];
                                      String strFrom = formatTime(num: from);
                                      String strTo = formatTime(num: to);
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            if(!cubit.startTimes[index]["isBooked"]&&!cubit.startTimes[index]["isDone"]){
                                              cubit.selected[index] = !cubit.selected[index];
                                              if(cubit.selected[index]) {
                                                count++;
                                              } else {
                                                count--;
                                              }
                                              cubit.changeRowColor();
                                            }
                                          },
                                          child: Container(
                                            color: cubit.selected[index]? defaultColor:Colors.white,
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.center,
                                                  children: [
                                                    Text("$day ${DateFormat.yMMMd().format(DateTime.parse(dateController.text))}"),
                                                    SizedBox(width:10),
                                                    Text('from: $strFrom to: $strTo'),
                                                  ],
                                                ),
                                                const SizedBox(height:10),
                                                ConditionalBuilder(
                                                  condition:cubit.startTimes[index]["userId"]!="",
                                                  builder: (context) {
                                                    return Row(
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('${cubit.startTimes[index]["userName"]}'),
                                                            Text('${cubit.startTimes[index]["userPhone"]}'),
                                                            Text('${cubit.startTimes[index]["randomNumber"]}'),
                                                            Text('Payed')
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        Column(
                                                          children: [
                                                            Container(
                                                              height: 30,
                                                              color: defaultColor,
                                                              child: MaterialButton(
                                                                onPressed: () {
                                                                  // cubit.changeNotify();
                                                                  // notify = !notify;
                                                                },
                                                                child: Row(
                                                                  children: const [
                                                                    Icon(
                                                                      Icons.call,
                                                                      color: Colors.white,
                                                                      size: 12,
                                                                    ),
                                                                    Text(
                                                                      'Contact',
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 12),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            ConditionalBuilder(
                                                              condition:cubit.startTimes[index]["userId"]=="booked by admin",
                                                              builder: (context) {
                                                                return Column(
                                                                  children: [
                                                                    SizedBox(height:10),
                                                                    Container(
                                                                      height: 30,
                                                                      color: Colors.red,
                                                                      child: MaterialButton(
                                                                        onPressed: () {
                                                                          cubit.updateBookingTimeModel(
                                                                              cityId: LoginCubit.get(context).adminModel["cityId"],
                                                                              schoolId: LoginCubit.get(context).adminModel["schoolId"],
                                                                              date: dateController.text,
                                                                              field: (cubit.currentIndex + 1).toString(),
                                                                              from: cubit.startTimes[index]["from"].toString(),
                                                                              data: {
                                                                                "isBooked": false,
                                                                                "userId": "",
                                                                                "userPhone": "",
                                                                                "userName": "",
                                                                                "randomNumber":""
                                                                              });
                                                                        },
                                                                        child: Row(
                                                                          children: const [
                                                                            Text(
                                                                              'Cancel',
                                                                              style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 12),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                              fallback:(context){
                                                                return Container();
                                                              }
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    );
                                                  },
                                                  fallback: (context){
                                                    return ConditionalBuilder(
                                                      condition: !cubit.startTimes[index]["isDone"],
                                                      builder: (context) => Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text('Not Booked')
                                                              ],
                                                            ),

                                                          ],
                                                        ),
                                                      fallback: (context) => Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text('Not Booked & Done')
                                                            ],
                                                          ),

                                                        ],
                                                      ),

                                                    );
                                                  }
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) => myDivider(),
                                    itemCount: cubit.startTimes.length
                                ),
                                const SizedBox(height:15),
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 40,
                                  color: defaultColor,
                                  child: MaterialButton(
                                    onPressed: () {
                                      if(count>0) {
                                        Alert(
                                          context: context,
                                          content: Form(
                                            key: formKey,
                                            child: Column(
                                              children: [
                                                defaultFormField(
                                                    prefix: Icons.people_alt_outlined,
                                                    text: 'Name',
                                                    controller: nameController,
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Name must not be empty";
                                                      }
                                                    }
                                                ),
                                                SizedBox(height: 15),
                                                defaultFormField(
                                                    prefix: Icons.phone_android_outlined,
                                                    text: 'Phone',
                                                    keyboardType: TextInputType.phone,
                                                    controller: phoneController,
                                                    validate: (value) {
                                                      if (value!.isEmpty) {
                                                        return "Phone must not be empty";
                                                      }
                                                    }
                                                ),
                                                SizedBox(height: 15),
                                                Container(
                                                  color: Colors.red,
                                                  width: 120,
                                                  height: 40,
                                                  child: defaultTextButton(
                                                      color: Colors.white,
                                                      text: 'Book',
                                                      function: () {
                                                        String randomNumber = "";
                                                        for(int j=1;j<=6;j++){
                                                          randomNumber+="${random.nextInt(10)}";
                                                        }
                                                        var from = [];
                                                        for (int i = 0; i < cubit.selected.length; i++) {
                                                          if (cubit.selected[i]) {
                                                            from.add(cubit.startTimes[i]["from"]);
                                                          }
                                                        }
                                                        if (formKey.currentState!.validate()) {
                                                          for (int j = 0; j < from.length; j++) {
                                                            cubit.updateBookingTimeModel(
                                                                cityId: LoginCubit.get(context).adminModel["cityId"],
                                                                schoolId: LoginCubit.get(context).adminModel["schoolId"],
                                                                date: dateController.text,
                                                                field: (cubit.currentIndex + 1).toString(),
                                                                from: from[j].toString(),
                                                                data: {
                                                                  "isBooked": true,
                                                                  "userId": "booked by admin",
                                                                  "userName": nameController.text,
                                                                  "userPhone": phoneController.text,
                                                                  "randomNumber": randomNumber
                                                                });
                                                          }
                                                          showToast(text:"You have booked successfully",state:ToastStates.SUCCESS);
                                                          Navigator.pop(context);
                                                        }
                                                      }
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          buttons: [],

                                        ).show();
                                      }

                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Book',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                  ],


          ),
              ),
            ),);
        });
  }
}
