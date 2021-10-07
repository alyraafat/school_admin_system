

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget buildSchool(context,school) => Container(
    child: Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        child: InkWell(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 2,
                child: Column(
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(30),
                              topEnd: Radius.circular(30)
                          )
                      ),
                      height: 150,
                      width: double.infinity,
                      child: defaultCarouselSlider(),
                      // child: Image(
                      //   fit: BoxFit.cover,
                      //     image: NetworkImage("https://image.made-in-china.com/2f0j00NQzGaAiBOYcg/Synthetic-Grass-for-Indoor-Soccer-Field-M60-.jpg")
                      // ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsetsDirectional.only(
                                        start: 7
                                    ) ,
                                    child: Text(
                                      school["name"],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(height:10),
                                  defaultRatingBar(school["rating"]),
                                  // RatingBar(
                                  //   itemSize: 25,
                                  //   initialRating: 0,
                                  //   direction: Axis.horizontal,
                                  //   allowHalfRating: true,
                                  //   itemCount: 5,
                                  //   ratingWidget: RatingWidget(
                                  //     full: Image(
                                  //       image: AssetImage('assets/images/full_ball.png'),
                                  //     ),
                                  //     half: Image(
                                  //         image: AssetImage('assets/images/full_ball.png'),
                                  //     ),
                                  //     empty: Image(
                                  //         image:AssetImage('assets/images/empty_ball.png'),
                                  //     )
                                  //   ),
                                  //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                  //   onRatingUpdate: (rating) {
                                  //     print(rating);
                                  //   },
                                  // )
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    school["location"],
                                    style: TextStyle(
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                  SizedBox(
                                      height: 15
                                  ),
                                  Text(
                                    '${school["fees"]} EGP/hr',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              )
                            ]
                        ),
                      ),
                    ),


                  ],
                ),
              ),
            ],
          ),
          onTap: (){

          },
        ),
      ),
    )
);

Widget myDivider() => Container(
  color: Color(0xff388E3C).withOpacity(0.7),
  height: 1,
  width: double.infinity,
);

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required void Function()? onPressed,
  required String text,
}) => Container(
  width: width,
  height: 50.0,
  child: MaterialButton(
    onPressed: onPressed,
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(
      radius,
    ),
    color: background,
  ),
);

Widget defaultTextButton({
  required void Function()? function,
  double? fontSize,
  required String text,
  Color? color = const Color(0xff388E3C),
  Color? backGroundColor,
}) => TextButton(
  onPressed: function,
  child: Text(
    text,
    style: TextStyle(
      color: color,
      backgroundColor: backGroundColor,
      fontSize: fontSize,
    ),
  ),
);


Widget defaultFormField({
  required IconData prefix,
  IconData? suffix,
  required String text,
  TextEditingController? controller,
  void Function(String)? onChange,
  void Function()? onTap,
  TextInputType? keyboardType,
  String? Function(String?)? validate,
  void Function()? suffixOnPressed,
  bool isObscure = false,
  TextDirection textDirection = TextDirection.rtl

}) => Container(
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 1, color:Color(0xff388E3C)),
    ),
    color: Colors.white,
  ),
  child: Directionality(
    textDirection: textDirection,
    child: TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: isObscure,
      onChanged: onChange,
      onTap: onTap ,
      validator: validate,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xff388E3C),
              )
          ),
          prefixIcon: Icon(
            prefix,
            color: Color(0xff388E3C),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              suffix,
              color: Color(0xff388E3C),
            ),
            onPressed: suffixOnPressed,
          ),
          labelText: text,
          labelStyle: TextStyle(
              color: Color(0xff388E3C)
          )
      ),
    ),
  ),
);

String formatTime({
  required dynamic num,
}) {
  String strNum = "";
  if (num > 12) {
    strNum = "${num - 12} pm";
  } else if (num == 0) {
    strNum = "12 am";
  } else if (num == 12) {
    strNum = "12 pm";
  } else {
    strNum = "$num am";
  }
  return strNum;
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish(
    context, widget,
    ) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      result: (route) {
        return false;
      },
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

Widget defaultRatingBar(double rating) =>  RatingBar.builder(
  ignoreGestures: true,
  glowRadius: 10,
  glowColor: Color(0xff388E3C),
  itemSize: 25,
  initialRating: rating,
  minRating: 1,
  direction: Axis.horizontal,
  allowHalfRating: true,
  itemCount: 5,
  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
  itemBuilder: (context, _) => Icon(
    Icons.sports_soccer,
    color: Color(0xff388E3C),
  ),
  onRatingUpdate: (rating) {
    print(rating);
  },
);

Widget defaultCarouselSlider() => Container(
  clipBehavior: Clip.antiAliasWithSaveLayer,
  decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.all(
        Radius.circular(30),
      )
  ),
  child: CarouselSlider(
    items: [
      Image(
          width: double.infinity,
          fit: BoxFit.cover,
          image: NetworkImage("https://image.made-in-china.com/2f0j00NQzGaAiBOYcg/Synthetic-Grass-for-Indoor-Soccer-Field-M60-.jpg")
      ),
      Image(
          width: double.infinity,
          fit: BoxFit.cover,
          image: NetworkImage("https://www.fcbarcelona.com/photo-resources/2020/02/24/3f1215ed-07e8-47ef-b2c7-8a519f65b9cd/mini_UP3_20200105_FCB_VIS_View_1a_Empty.jpg?width=1200&height=750")
      ),
    ],
    options: CarouselOptions(
      //height: 200,
      viewportFraction: 1.0,
      enlargeCenterPage: false,
      initialPage: 0,
      enableInfiniteScroll: true,
      reverse: false,
      autoPlay: true,
      autoPlayInterval: Duration(seconds: 3),
      autoPlayAnimationDuration: Duration(seconds: 1),
      autoPlayCurve: Curves.fastOutSlowIn,
      scrollDirection: Axis.horizontal,
    ),

  ),
);

Widget timeBuilder() => Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Card(
    shape: RoundedRectangleBorder(

      borderRadius: BorderRadius.circular(30),
    ),
    elevation: 2,
    child:   Column(
      children: [
        Text('Date, from: to: '),
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              child: Image(
                  image: AssetImage('assets/images/empty_ball.png')
              ),
            ),
            SizedBox(width:10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text('Egyptian Language School'),
                Text('Field 1'),
              ],
            ),
            Spacer(),
            MaterialButton(
              onPressed: () {},
              child: Row(
                children: [
                  Icon(Icons.notification_important),
                  Text('Notify Me')
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  ),
);

Widget rowBuilder() => Container(
  height: 140,
  width: double.infinity,
  child:   Row(
    children: [
      Row(
        children: [
          Container(
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadiusDirectional.only(
            //         topStart: Radius.circular(30),
            //         topEnd: Radius.circular(30)
            //     )
            // ),
            height: 140,
            width: 160,
            child: defaultCarouselSlider(),
            // child: Image(
            //   fit: BoxFit.cover,
            //     image: NetworkImage("https://image.made-in-china.com/2f0j00NQzGaAiBOYcg/Synthetic-Grass-for-Indoor-Soccer-Field-M60-.jpg")
            // ),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text(
                  'Egyptian Language School',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  '4/7/2002',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'from: 10pm to: 4pm',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Field 1',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text('300'),
                Spacer(),
                Container(
                  color: Color(0xff388E3C),
                  height: 35,
                  child: TextButton(
                    onPressed: () {  },

                    child: Row(
                      children: [
                        Icon(Icons.location_on ,
                          color: Colors.white,),
                        Text('Location',
                            style: TextStyle(
                              color:Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),


        ],
      ),
    ],
  ),
);

Widget tournamentsBuilder() => Container(
  height: 150,
  width: double.infinity,
  child:   Row(
    children: [
      Row(
        children: [
          Container(
            //clipBehavior: Clip.antiAliasWithSaveLayer,
            // decoration: BoxDecoration(
            //     borderRadius: BorderRadiusDirectional.only(
            //         topStart: Radius.circular(30),
            //         topEnd: Radius.circular(30)
            //     )
            // ),
            height: 100,
            width: 120,
            child: Image(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/empty_ball.png')
            ),
          ),
          SizedBox(width: 10,),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
              children: [
                Text(
                  'Champions League',
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 10,),
                Text('Egyptian Language School'),
                Text(
                  '4/7/2002',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'from: 10pm to: 4pm',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Field 1',
                  maxLines: 1,
                  style: TextStyle(

                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                Spacer(),
                Row(
                  children: [
                    Container(
                      color: Color(0xff388E3C),
                      height: 35,
                      child: TextButton(
                        onPressed: () {
                        },

                        child: Text('Apply',
                            style: TextStyle(
                              color:Colors.white,
                            )),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      color: Color(0xff388E3C),
                      height: 35,
                      child: TextButton(
                        onPressed: () {  },

                        child: Row(
                          children: [
                            Icon(Icons.location_on ,
                              color: Colors.white,),
                            Text('Location',
                                style: TextStyle(
                                  color:Colors.white,
                                ))
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),


        ],
      ),
    ],
  ),
);

Widget myFriend() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child:   Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child:   Row(
          children: [
            Row(
              children: [
                // Container(
                //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                //   // decoration: BoxDecoration(
                //   //     borderRadius: BorderRadiusDirectional.only(
                //   //         topStart: Radius.circular(30),
                //   //         topEnd: Radius.circular(30)
                //   //     )
                //   // ),
                //   height: 100,
                //   width: 120,
                //   child: Image(
                //       fit: BoxFit.contain,
                //       image: AssetImage('assets/images/empty_ball.png')
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Karim Gamaleldin',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Points'),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color(0xff388E3C),
                              ),

                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                },

                                child: Text('Invite',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff388E3C),
                            ),
                            height: 35,
                            child: TextButton(
                              onPressed: () {  },

                              child: Text('Unfriend',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:Colors.white,
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    ),
  ),
);

Widget myRequests() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    child:   Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 8,
        end: 10,
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        child:   Row(
          children: [
            Row(
              children: [
                // Container(
                //   //clipBehavior: Clip.antiAliasWithSaveLayer,
                //   // decoration: BoxDecoration(
                //   //     borderRadius: BorderRadiusDirectional.only(
                //   //         topStart: Radius.circular(30),
                //   //         topEnd: Radius.circular(30)
                //   //     )
                //   // ),
                //   height: 100,
                //   width: 120,
                //   child: Image(
                //       fit: BoxFit.contain,
                //       image: AssetImage('assets/images/empty_ball.png')
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: [
                      Text(
                        'Karim Gamaleldin',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,

                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 2,),
                      Text('Points'),
                      Spacer(),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color(0xff388E3C),
                              ),

                              height: 35,
                              child: TextButton(
                                onPressed: () {
                                },

                                child: Text('Accept',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:Colors.white,
                                    )),
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              color: Color(0xff388E3C),
                            ),
                            height: 35,
                            child: TextButton(
                              onPressed: () {  },

                              child: Text('Decline',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:Colors.white,
                                  )),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),


              ],
            ),
          ],
        ),
      ),
    ),
  ),
);




