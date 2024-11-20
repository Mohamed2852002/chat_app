import 'package:chat_app/firestore/firestore_handler.dart';
import 'package:chat_app/firestore/models/message.dart';
import 'package:chat_app/ui/screens/chat/widgets/custom_text_field.dart';
import 'package:chat_app/ui/screens/chat/widgets/message_bubble_widget.dart';
import 'package:chat_app/ui/screens/chat/widgets/recieved_bubble_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    super.key,
    required this.streamFunction,
    this.isCommon = false,
  });
  static const String routeName = 'chat';
  final TextEditingController controller = TextEditingController();
  final ScrollController listController = ScrollController();
  final Stream<List<Message>> streamFunction;
  final bool isCommon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          children: [
            RSizedBox(width: 60),
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: streamFunction,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(child: Text('There was an Error'));
                }
                List<Message> messages = snapshot.data ?? [];
                return ListView.separated(
                  reverse: true,
                  controller: listController,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16.h,
                  ),
                  itemBuilder: (context, index) {
                    if (messages[index].messageId ==
                        FirebaseAuth.instance.currentUser!.email!) {
                      return MessageBubbleWidget(
                        message: messages[index],
                      );
                    } else {
                      return RecievedBubbleWidget(message: messages[index]);
                    }
                  },
                  itemCount: messages.length,
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: CustomTextField(
              onBtnPressed: () {
                if (isCommon) {
                  createNewCommonMessage();
                } else {
                  createNewMessage();
                }
              },
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }

  createNewMessage() {
    if (controller.text != '') {
      FirestoreHandler.createMessage(
        Message(
          content: controller.text,
          messageTime: Timestamp.fromDate(
            DateTime.now(),
          ),
          messageId: FirebaseAuth.instance.currentUser!.email!,
        ),
        FirebaseAuth.instance.currentUser!.uid,
      );
      controller.clear();
      listController.animateTo(
        listController.position.minScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  createNewCommonMessage() {
    if (controller.text != '') {
      FirestoreHandler.createCommonMessage(
        Message(
          content: controller.text,
          messageTime: Timestamp.fromDate(
            DateTime.now(),
          ),
          messageId: FirebaseAuth.instance.currentUser!.email!,
        ),
        FirebaseAuth.instance.currentUser!.uid,
      );
      controller.clear();
      listController.animateTo(
        listController.position.minScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }
}
