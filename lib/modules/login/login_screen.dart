
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:school_admin_system/modules/adminsystemscreen.dart';
import 'package:school_admin_system/shared/components.dart';
import 'package:school_admin_system/shared/constants.dart';
import 'package:school_admin_system/Network/local/cache_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';


class LoginScreen extends StatelessWidget
{
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) {
        if (state is LoginErrorState) {
          showToast(
            text: state.error,
            state: ToastStates.ERROR,
          );
        }
        if(state is LoginSuccessState)
        {
          CacheHelper.saveData(
            key: 'adminId',
            value: state.uid,
          ).then((value)
          {
            navigateAndFinish(
              context,
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: AdminSystemScreen()
              ),
            );
          }
          );
        }
      },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Text(
                              'تسجيل الدخول',
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black, fontSize: 40)
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      defaultFormField(
                        textDirection: TextDirection.ltr,
                        controller: emailController,
                        validate: (value){
                          if(value!.isEmpty) return ('لا يجب أن يكون البريد الإلكتروني فارغًا');
                        },
                        text: 'البريد الإلكتروني',
                        prefix: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                          textDirection: TextDirection.ltr,
                          controller: passwordController,
                          validate: (value){
                            if(value!.isEmpty) return ('يجب ألا تكون كلمة المرور فارغة');
                          },
                          isObscure: LoginCubit.get(context).isPassword,
                          text: 'كلمه السر',
                          prefix: Icons.lock_outline,
                          suffix: LoginCubit.get(context).suffix,
                          suffixOnPressed: () {
                            LoginCubit.get(context).changePasswordVisibility();
                          }
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder: (context) => defaultButton(
                            text: 'تسجيل الدخول',
                            background: defaultColor,
                            isUpperCase: true,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context
                                );
                              }
                            }
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator(
                              color:defaultColor
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}