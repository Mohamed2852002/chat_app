import 'package:chat_app/firestore/firestore_handler.dart';
import 'package:chat_app/style/theme/app_colors.dart';
import 'package:chat_app/ui/screens/chat/chat_screen.dart';
import 'package:chat_app/ui/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RSizedBox(
                    width: 60,
                    child: Image.asset('assets/images/scholar.png'),
                  ),
                  Text(
                    'Chat',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                        (route) => false,
                      );
                    },
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    streamFunction: FirestoreHandler.getCommonMessages(),
                    isCommon: true,
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Common Messages'),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    streamFunction: FirestoreHandler.getMessages(
                      FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                ),
              );
            },
            child: Container(
              width: double.infinity,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Single Person Messages'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
