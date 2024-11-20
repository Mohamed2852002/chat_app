// ignore_for_file: use_build_context_synchronously
import 'package:chat_app/constants.dart';
import 'package:chat_app/firestore/firestore_handler.dart';
import 'package:chat_app/firestore/models/users.dart' as myuser;
import 'package:chat_app/ui/reusable_components/custom_button.dart';
import 'package:chat_app/ui/reusable_components/custom_loading_dialog.dart';
import 'package:chat_app/ui/reusable_components/custom_message_dialog.dart';
import 'package:chat_app/ui/reusable_components/custom_form_text_field.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  static const String routeName = 'signup';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
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
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 26.sp,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomFormTextField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Your Name';
                          }
                          return null;
                        },
                        controller: nameController,
                        label: 'Full Name',
                        textInputType: TextInputType.name),
                    SizedBox(height: 14.h),
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
                        textInputType: TextInputType.emailAddress),
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
                      text: 'Sign Up',
                      onBtnPress: () {
                        signUp(context);
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have an Account ? ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign In',
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
    );
  }

  signUp(BuildContext context) async {
    if (formKey.currentState!.validate() == true) {
      try {
        showDialog(
          context: context,
          builder: (context) => CustomLoadingDialog(),
        );
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        FirestoreHandler.createUser(
          myuser.User(
            email: emailController.text,
            id: credential.user!.uid,
            name: nameController.text,
          ),
        );
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'weak-password') {
          showDialog(
            context: context,
            builder: (context) => CustomMessageDialog(
              message: 'Please Enter Stronger Password.',
              positiveBtnText: 'Ok',
              onPositiveBtnPress: () {
                Navigator.pop(context);
              },
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          showDialog(
            context: context,
            builder: (context) => CustomMessageDialog(
              message: 'An Account is already exists for that Email.',
              positiveBtnText: 'Ok',
              onPositiveBtnPress: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => CustomMessageDialog(
            message: 'Unexpected Error Occured : ${e.toString()}',
            positiveBtnText: 'Ok',
            onPositiveBtnPress: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    }
  }
}