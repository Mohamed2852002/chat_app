import 'package:chat_app/cubits/chat_cubit/chat_state.dart';
import 'package:chat_app/firestore/firestore_handler.dart';
import 'package:chat_app/firestore/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  createNewMessage(
      {required TextEditingController controller,
      required ScrollController listController}) {
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

  createNewCommonMessage(
      {required TextEditingController controller,
      required ScrollController listController}) {
    if (controller.text != '') {
      FirestoreHandler.createCommonMessage(
        Message(
          content: controller.text,
          messageTime: Timestamp.fromDate(
            DateTime.now(),
          ),
          messageId: FirebaseAuth.instance.currentUser!.email!,
        ),
      );
      controller.clear();
      listController.animateTo(
        listController.position.minScrollExtent,
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    }
  }

  getCommonMessages() {
    FirestoreHandler.getCommonMessageCollection()
        .orderBy('Time', descending: true)
        .snapshots()
        .listen(
      (event) {
        List<Message> messages = event.docs
            .map(
              (e) => e.data(),
            )
            .toList();

        emit(ChatSuccess(messages: messages));
      },
    );
  }

  getMessages(String userId) {
    FirestoreHandler.getMessageCollection(userId)
        .orderBy('Time', descending: true)
        .snapshots()
        .listen(
      (event) {
        List<Message> messages = event.docs
            .map(
              (e) => e.data(),
            )
            .toList();

        emit(ChatSuccess(messages: messages));
      },
    );
  }
}
