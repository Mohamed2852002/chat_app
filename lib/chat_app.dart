import 'package:chat_app/style/theme/app_theme.dart';
import 'package:chat_app/ui/screens/home/home_screen.dart';
import 'package:chat_app/ui/screens/login/login_screen.dart';
import 'package:chat_app/ui/screens/register/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        initialRoute: FirebaseAuth.instance.currentUser != null
            ? HomeScreen.routeName
            : LoginScreen.routeName,
        routes: {
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          HomeScreen.routeName : (context)=> HomeScreen(),
        },
        theme: AppTheme.apptheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
