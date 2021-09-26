import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_admin_system/modules/login/cubit/states.dart';
import 'package:school_admin_system/shared/constants.dart';
import 'package:school_admin_system/cubit/cubit.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);
  var adminModel = {};
  void userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) {
    emit(LoginLoadingState());
    FirebaseFirestore.instance
        .collection('school_admins')
        .get()
        .then((value) {
      for(int i=0;i<value.size;i++){
        if(email==value.docs[i].data()["email"]&&password==value.docs[i].data()["password"]){
          adminModel = value.docs[i].data();
          emit(LoginSuccessState(adminModel["adminId"]));
          break;
        }
      }
      AppCubit.get(context).getOneSchoolData(cityId: adminModel["cityId"], schoolId: adminModel["schoolId"]);
    }).catchError((error){
      print(error.toString());
      emit(LoginErrorState(error));
    });
  }


  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined ;

    emit(ChangePasswordVisibilityState());
  }
}