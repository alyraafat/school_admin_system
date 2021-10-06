import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:school_admin_system/Network/local/cache_helper.dart';
import 'package:school_admin_system/modules/login/cubit/cubit.dart';
import 'package:school_admin_system/modules/login/login_screen.dart';
import 'package:school_admin_system/shared/components.dart';
import 'package:school_admin_system/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AdminSystemScreen extends StatelessWidget {
  var dateController = TextEditingController();
  var fieldController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String day = "";
  var count = 0;
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is AppGetAdminSuccessState){
            cubit.getOneSchoolData(
                cityId: AppCubit.get(context).adminModel["cityId"],
                schoolId: AppCubit.get(context).adminModel["schoolId"]
            );
          }
        },
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
              actions: [
                IconButton(
                  icon: Icon(
                      Icons.logout_outlined,
                    color: defaultColor,
                  ),
                  onPressed: (){
                    CacheHelper.saveData(key: "adminId", value: "");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                          (route) {
                        return false;
                      },
                    );
                  },
                )
              ],
            ),
            body:ConditionalBuilder(
              condition: cubit.oneSchool.isNotEmpty,
              builder: (context) {
                return Padding(
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
                                    text: "ملعب ${index+1}",
                                    function: () {
                                      cubit.currentIndex = index;
                                      cubit.changeField();
                                      if(dateController.text.isNotEmpty) {
                                          if (cubit.oneSchool["calendar${cubit.currentIndex + 1}"][day].length != 1) {
                                            AppCubit.get(context).checkDateInDataBase(
                                                    date: dateController.text,
                                                    cityId: cubit.adminModel["cityId"],
                                                    schoolId: cubit.adminModel["schoolId"],
                                                    field: (cubit.currentIndex + 1).toString(),
                                                    fees: cubit.oneSchool["fees"],
                                                    intervals: cubit.oneSchool["calendar${cubit.currentIndex + 1}"][day]
                                            );
                                          }
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
                              theme: ThemeData(
                                primaryColor: Colors.white,
                              ),
                              styleDatePicker: MaterialRoundedDatePickerStyle(
                                textStyleDayButton:
                                const TextStyle(fontSize: 36, color: Colors.white),
                                textStyleYearButton: const TextStyle(
                                  fontSize: 52,
                                  color: Colors.black,
                                ),
                                textStyleDayHeader: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                ),
                                textStyleCurrentDayOnCalendar: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textStyleDayOnCalendar:
                                const TextStyle(fontSize: 28, color: Colors.black),
                                textStyleDayOnCalendarSelected: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                textStyleDayOnCalendarDisabled: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.black),
                                textStyleMonthYearHeader: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                paddingDatePicker: const EdgeInsets.all(0),
                                paddingMonthHeader: const EdgeInsets.all(32),
                                paddingActionBar: const EdgeInsets.all(16),
                                paddingDateYearHeader: const EdgeInsets.all(32),
                                sizeArrow: 50,
                                colorArrowNext: Colors.black,
                                colorArrowPrevious: Colors.black,
                                marginLeftArrowPrevious: 16,
                                marginTopArrowPrevious: 16,
                                marginTopArrowNext: 16,
                                marginRightArrowNext: 32,
                                textStyleButtonAction:
                                const TextStyle(fontSize: 28, color: Colors.white),
                                textStyleButtonPositive: const TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                textStyleButtonNegative: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black.withOpacity(0.5)),
                                decorationDateSelected: BoxDecoration(
                                    color: defaultColor,
                                    shape: BoxShape.circle),
                                backgroundPicker: Colors.white,
                                backgroundActionBar: Colors.white,
                                backgroundHeaderMonth: Colors.white,
                              ),
                              styleYearPicker: MaterialRoundedYearPickerStyle(
                                textStyleYear:
                                const TextStyle(fontSize: 40, color: Colors.black),
                                textStyleYearSelected: const TextStyle(
                                    fontSize: 56,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                heightYearRow: 100,
                                backgroundPicker: Colors.black,
                              )).then((value) {
                                day = AppCubit.get(context).dateToDay(date: value.toString());
                                dateController.text = DateFormat("yyyy-MM-dd").format(value!);
                                if(cubit.oneSchool["calendar${cubit.currentIndex+1}"][day].length != 1) {
                                  AppCubit.get(context).checkDateInDataBase(
                                      date: dateController.text,
                                      cityId: cubit.adminModel["cityId"],
                                      schoolId: cubit.adminModel["schoolId"],
                                      field: (cubit.currentIndex+1).toString(),
                                      fees: cubit.oneSchool["fees"],
                                      intervals:cubit.oneSchool["calendar${cubit.currentIndex+1}"][day]);
                                }
                                AppCubit.get(context).changeDate();
                          });
                        }),
                        SizedBox(height:10),
                        Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ConditionalBuilder(
                                  condition: dateController.text.isNotEmpty,
                                  builder: (context) {
                                    return ConditionalBuilder(
                                      condition: cubit.oneSchool["calendar${cubit.currentIndex+1}"][day].length != 1,
                                      builder: (context) {
                                        return Column(
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
                                                        color: cubit.selected[index]? defaultColor:(cubit.startTimes[index]["isDeposit"]&&!cubit.startTimes[index]["depositPaid"])?Colors.grey[300]:Colors.white,
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:MainAxisAlignment.center,
                                                                children: [
                                                                  Text("${cubit.dayInArabic(day:day)} ${DateFormat.yMMMd().format(DateTime.parse(dateController.text))}"),
                                                                  const SizedBox(width:10),
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
                                                                          Text(DateFormat.yMMMd().format(DateTime.parse(cubit.startTimes[index]["bookingDate"]))),
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
                                                                                launch("tel://${cubit.startTimes[index]["userPhone"]}");
                                                                              },
                                                                              child: Row(
                                                                                children: const [
                                                                                  Text(
                                                                                    'قم بالاتصال',
                                                                                    style: TextStyle(
                                                                                        color: Colors.white,
                                                                                        fontSize: 12),
                                                                                  ),
                                                                                  SizedBox(width:5),
                                                                                  Icon(
                                                                                    Icons.call,
                                                                                    color: Colors.white,
                                                                                    size: 12,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          ConditionalBuilder(
                                                                            condition:cubit.startTimes[index]["userId"]=="booked by admin",
                                                                            builder: (context) {
                                                                              return Column(
                                                                                children: [
                                                                                  const SizedBox(height:10),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    color: Colors.red,
                                                                                    child: MaterialButton(
                                                                                      onPressed: () {
                                                                                        Alert(
                                                                                            context: context,
                                                                                          content:Column(
                                                                                            children: [
                                                                                              const Text("هل انت متأكد من إلغاء هذا الحجز؟"),
                                                                                              const SizedBox(height:10),
                                                                                              Container(
                                                                                                height:40,
                                                                                                width: 100,
                                                                                                color: Colors.red,
                                                                                                child: MaterialButton(
                                                                                                  onPressed: () {
                                                                                                    cubit.updateBookingTimeModel(
                                                                                                        cityId:cubit.adminModel["cityId"],
                                                                                                        schoolId: cubit.adminModel["schoolId"],
                                                                                                        date: dateController.text,
                                                                                                        field: (cubit.currentIndex + 1).toString(),
                                                                                                        from: cubit.startTimes[index]["from"].toString(),
                                                                                                        data: {
                                                                                                          "isBooked": false,
                                                                                                          "userId": "",
                                                                                                          "userPhone": "",
                                                                                                          "userName": "",
                                                                                                          "randomNumber":"",
                                                                                                          "isDeposit":false,
                                                                                                          "depositPaid":false,
                                                                                                          "bookingDate":""
                                                                                                        });
                                                                                                    Navigator.pop(context);
                                                                                                  },
                                                                                                  child: const Text(
                                                                                                    "إلغاء",
                                                                                                    style: TextStyle(
                                                                                                      color: Colors.white
                                                                                                    ),
                                                                                                  ),

                                                                                                ),
                                                                                              )
                                                                                            ],
                                                                                          ),
                                                                                          buttons: []

                                                                                        ).show();
                                                                                      },
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          Text(
                                                                                            'إلغاء',
                                                                                            style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontSize: 12
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              );
                                                                            },
                                                                            fallback:(context)=>ConditionalBuilder(
                                                                              condition: cubit.startTimes[index]["isDeposit"]&&!cubit.startTimes[index]["depositPaid"],
                                                                              builder: (context)=>Column(
                                                                                children: [
                                                                                  const SizedBox(height:10),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    color: defaultColor,
                                                                                    child: MaterialButton(
                                                                                      onPressed: () {
                                                                                        Alert(
                                                                                            context: context,
                                                                                            content:Column(
                                                                                              children: [
                                                                                                const Text("تم الدفع؟"),
                                                                                                const SizedBox(height:10),
                                                                                                Container(
                                                                                                  height:40,
                                                                                                  width: 100,
                                                                                                  color: defaultColor,
                                                                                                  child: MaterialButton(
                                                                                                    onPressed: () {
                                                                                                      cubit.updateBookingTimeModel(
                                                                                                          cityId:cubit.adminModel["cityId"],
                                                                                                          schoolId: cubit.adminModel["schoolId"],
                                                                                                          date: dateController.text,
                                                                                                          field: (cubit.currentIndex + 1).toString(),
                                                                                                          from: cubit.startTimes[index]["from"].toString(),
                                                                                                          data: {
                                                                                                            "depositPaid":true
                                                                                                          });
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    child: const Text(
                                                                                                      "موافق",
                                                                                                      style: TextStyle(
                                                                                                          color: Colors.white
                                                                                                      ),
                                                                                                    ),

                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            buttons: []
                                                                                        ).show();

                                                                                      },
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          Text(
                                                                                            'تم الدفع؟',
                                                                                            style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontSize: 12
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height:10),
                                                                                  Container(
                                                                                    height: 30,
                                                                                    color: Colors.red,
                                                                                    child: MaterialButton(
                                                                                      onPressed: () {
                                                                                        cubit.getUserData(uId: cubit.startTimes[index]["userId"]);
                                                                                        Alert(
                                                                                            context: context,
                                                                                            content:Column(
                                                                                              children: [
                                                                                                const Text("هل انت متأكد من إلغاء هذا الحجز؟"),
                                                                                                const SizedBox(height:10),
                                                                                                Container(
                                                                                                  height:40,
                                                                                                  width: 100,
                                                                                                  color: Colors.red,
                                                                                                  child: MaterialButton(
                                                                                                    onPressed: () {
                                                                                                      cubit.updateBookingTimeModel(
                                                                                                          cityId:cubit.adminModel["cityId"],
                                                                                                          schoolId: cubit.adminModel["schoolId"],
                                                                                                          date: dateController.text,
                                                                                                          field: (cubit.currentIndex + 1).toString(),
                                                                                                          from: cubit.startTimes[index]["from"].toString(),
                                                                                                          data: {
                                                                                                            "isBooked": false,
                                                                                                            "userId": "",
                                                                                                            "userPhone": "",
                                                                                                            "userName": "",
                                                                                                            "randomNumber":"",
                                                                                                            "isDeposit":false,
                                                                                                            "depositPaid":false,
                                                                                                            "bookingDate":""
                                                                                                          }
                                                                                                      );
                                                                                                      for(int i=0;i<cubit.userModel["mala3eb"].length;i++){
                                                                                                        if(
                                                                                                            cubit.adminModel["schoolId"]==cubit.userModel["mala3eb"][i]["schoolId"]
                                                                                                            &&cubit.adminModel["cityId"]==cubit.userModel["mala3eb"][i]["city"]
                                                                                                            &&dateController.text==cubit.userModel["mala3eb"][i]["date"]
                                                                                                        ){
                                                                                                          cubit.userModel["mala3eb"].removeAt(i);
                                                                                                          cubit.userModel["count"]--;
                                                                                                          cubit.updateUserData(
                                                                                                              data: {
                                                                                                                "mala3eb":cubit.userModel["mala3eb"],
                                                                                                                "count":cubit.userModel["count"]
                                                                                                              },
                                                                                                              uId: cubit.startTimes[index]["userId"]
                                                                                                          );
                                                                                                          break;
                                                                                                        }
                                                                                                      }
                                                                                                      Navigator.pop(context);
                                                                                                    },
                                                                                                    child: const Text(
                                                                                                      "إلغاء",
                                                                                                      style: TextStyle(
                                                                                                          color: Colors.white
                                                                                                      ),
                                                                                                    ),

                                                                                                  ),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            buttons: []

                                                                                        ).show();
                                                                                      },
                                                                                      child: Row(
                                                                                        children: const [
                                                                                          Text(
                                                                                            'إلغاء',
                                                                                            style: TextStyle(
                                                                                                color: Colors.white,
                                                                                                fontSize: 12),
                                                                                          )
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              fallback: (context)=>Container(),
                                                                            )
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
                                                                            children: const [
                                                                              Text('غير محجوز')
                                                                            ],
                                                                          ),

                                                                        ],
                                                                      ),
                                                                    fallback: (context) => Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Column(
                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                          children: const [
                                                                            Text('غير محجوز و انتهي')
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
                                                            const SizedBox(height: 15),
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
                                                            const SizedBox(height: 15),
                                                            Container(
                                                              color: defaultColor,
                                                              width: 120,
                                                              height: 40,
                                                              child: defaultTextButton(
                                                                  color: Colors.white,
                                                                  text: 'Book',
                                                                  function: () {
                                                                    var from = [];
                                                                    for (int i = 0; i < cubit.selected.length; i++) {
                                                                      if (cubit.selected[i]) {
                                                                        from.add(cubit.startTimes[i]["from"]);
                                                                      }
                                                                    }
                                                                    if (formKey.currentState!.validate()) {
                                                                      for (int j = 0; j < from.length; j++) {
                                                                        cubit.updateBookingTimeModel(
                                                                            cityId: cubit.adminModel["cityId"],
                                                                            schoolId: cubit.adminModel["schoolId"],
                                                                            date: dateController.text,
                                                                            field: (cubit.currentIndex + 1).toString(),
                                                                            from: from[j].toString(),
                                                                            data: {
                                                                              "isBooked": true,
                                                                              "userId": "booked by admin",
                                                                              "userName": nameController.text,
                                                                              "userPhone": phoneController.text,
                                                                              "randomNumber": "No random number",
                                                                              "isDeposit":false,
                                                                              "depositPaid":false,
                                                                              "bookingDate":DateFormat("yyyy-MM-dd").format(DateTime.now())
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
                                                      'احجز',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      fallback: (context)=>Text("No reservations on ${cubit.dayInArabic(day:day)} ${DateFormat.yMMMd().format(DateTime.parse(dateController.text))}"),
                                    );
                                  },
                                  fallback: (context)=>Container(),
                                ),
                              ),
                            ),
                        SizedBox(height:10),
                        Text(
                          "amount due: ${cubit.oneSchool["amountDue"]}",
                          style: TextStyle(
                              color:Colors.grey[600],
                              fontSize: 15
                          ),
                        )
                      ],


          ),
                  ),
                );
              },
              fallback: (context)=>Center(child:CircularProgressIndicator(
                color: defaultColor,
              )),
            ),);
        });
  }
}
