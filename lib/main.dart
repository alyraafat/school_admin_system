import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_admin_system/modules/adminsystemscreen.dart';
import 'package:school_admin_system/shared/my_bloc_observer.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';



void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  // await CacheHelper.init();
  // // bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  // bool? isDark = CacheHelper.getData(key: 'isDark');
  // uId = CacheHelper.getData(key: 'uId');
  // Widget startWidget;
  // // if(onBoarding)
  // // {
  // if (uId != "") {
  //   startWidget = BottomNavScreen();
  // } else {
  //   startWidget = LoginScreen();
  // }
  // }else{
  //   startWidget = OnBoardingScreen();
  // }
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AppCubit()

        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: AdminSystemScreen(),
          );
        },
      ),
    );
  }
}
