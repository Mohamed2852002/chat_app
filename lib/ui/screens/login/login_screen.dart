import 'package:chat_app/blocs/auth_bloc/auth_bloc.dart';
import 'package:chat_app/blocs/auth_bloc/auth_event.dart';
import 'package:chat_app/blocs/auth_bloc/auth_state.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/ui/reusable_components/custom_button.dart';
import 'package:chat_app/ui/reusable_components/custom_form_text_field.dart';
import 'package:chat_app/ui/reusable_components/custom_loading_dialog.dart';
import 'package:chat_app/ui/reusable_components/custom_message_dialog.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/ui/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  static const String routeName = 'login';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            builder: (context) => CustomLoadingDialog(),
          );
        } else if (state is LoginSuccess) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else if (state is LoginFailure) {
          Navigator.pop(context);
          if (state.errorMessage == 'user-not-found') {
            showDialog(
              context: context,
              builder: (context) => CustomMessageDialog(
                message: 'No User Found for That Email.',
                positiveBtnText: 'Ok',
                onPositiveBtnPress: () {
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state.errorMessage == 'wrong-password') {
            showDialog(
              context: context,
              builder: (context) => CustomMessageDialog(
                message: 'Wrong Password for That Email.',
                positiveBtnText: 'Ok',
                onPositiveBtnPress: () {
                  Navigator.pop(context);
                },
              ),
            );
          }
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'Scholar Chat',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontFamily: 'Pacifico',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 26.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      CustomFormTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Email';
                          }
                          if (!validEmail(value)) {
                            return 'Please Enter Valid Email';
                          }
                          return null;
                        },
                        controller: emailController,
                        label: 'Email',
                        textInputType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 14.h),
                      CustomFormTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Password';
                          }
                          if (value.length < 6) {
                            return 'Please Enter Strong Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        label: 'Password',
                        textInputType: TextInputType.visiblePassword,
                        isPassword: true,
                      ),
                      SizedBox(height: 20.h),
                      CustomButton(
                        text: 'Sign In',
                        onBtnPress: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthBloc>(context).add(
                              LoginEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t Have an Account ? ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xffC7EDE6),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
