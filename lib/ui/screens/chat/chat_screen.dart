import 'package:chat_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/firestore/models/message.dart';
import 'package:chat_app/ui/screens/chat/widgets/custom_text_field.dart';
import 'package:chat_app/ui/screens/chat/widgets/message_bubble_widget.dart';
import 'package:chat_app/ui/screens/chat/widgets/recieved_bubble_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class ChatScreen extends StatelessWidget {
  ChatScreen({super.key, this.isCommon = false});
  static const String routeName = 'chat';
  final TextEditingController controller = TextEditingController();
  final ScrollController listController = ScrollController();
  final bool isCommon;
  List<Message> messages = [];

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
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatSuccess) {
                  messages = state.messages;
                }
                return ListView.separated(
                  reverse: true,
                  controller: listController,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 16.h,
                  ),
                  itemCount: messages.length,
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
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: CustomTextField(
              onBtnPressed: () {
                if (isCommon) {
                  BlocProvider.of<ChatCubit>(context).createNewCommonMessage(
                    controller: controller,
                    listController: listController,
                  );
                } else {
                  BlocProvider.of<ChatCubit>(context).createNewMessage(
                    controller: controller,
                    listController: listController,
                  );
                }
              },
              controller: controller,
            ),
          ),
        ],
      ),
    );
  }
}
