import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:school_admin_system/shared/components.dart';
import 'package:school_admin_system/shared/constants.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AdminSystemScreen extends StatelessWidget {
  var fields = ['Field 1','Field 2', 'Field 3'];
  var dateController = TextEditingController();
  var fieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'App System',
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
                  const Text(

                  'Name of the school',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                    SizedBox(height: 20,),
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
                                text: fields[index],
                                function: () {
                                  cubit.currentIndex = index;
                                  cubit.changeField();
                                },
                                color: (cubit.currentIndex == index)?Colors.white: defaultColor ,
                            ),
                          ),
                          separatorBuilder: (context,index) => const SizedBox(width: 10,),
                          itemCount: fields.length
                      ),
                    ),
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
                        // day = AppCubit.get(context).dateToDay(date: value.toString());
                        // dateController.text = DateFormat.yMMMd().format(value!);
                        // print(TimeOfDay.now().hour);
                        // if(value==DateTime.now()&&school["calendar"][day][0]<TimeOfDay.now())
                        //   timeTable = AppCubit.get(context).createTimeTable(startTime: TimeOfDay.now().hour+1, endTime: school["calendar"][day][1]);
                        // else
                        // timeTable = AppCubit.get(context).createTimeTable(startTime: school["calendar"][day][0], endTime: school["calendar"][day][1]);
                        // if(school["calendar$currentField"][day].length != 1) {
                        //   AppCubit.get(context).checkDateInDataBase(date: dateController.text, cityId: AppCubit.get(context).currentCity, schoolId: school["schoolId"], field: currentField.toString(), fees: school["fees"],intervals:school["calendar$currentField"][day]);
                        // }
                        //AppCubit.get(context).changeDate();
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
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        Text('from: to: '),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text('Name of User'),
                                                Text('Mobile Phone Number'),
                                                Text('Random Number'),
                                                Text('Payed')
                                              ],
                                            ),
                                            const Spacer(),
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
                                                    Text('Contact',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                separatorBuilder: (context, index) => myDivider(),
                                itemCount: 10),
                          ],
                        ),
                      ),
                    ),
                  ],


          ),
              ),
            ),);
        });
  }
}
