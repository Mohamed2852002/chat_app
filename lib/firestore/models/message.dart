import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static const String collectionName = 'Messages';
  final String content;
  final Timestamp messageTime;
  final String messageId;
  Message({
    required this.content,
    required this.messageTime,
    required this.messageId,
  });

   Map<String,dynamic> toFirestore() {
    return {
      'Content' : content,
      'Time' : messageTime,
      'Id' : messageId,
    };
  }

  factory Message.fromFirestore(Map<String,dynamic>? data) {
    return Message(
      content: data?['Content'],
      messageTime: data?['Time'],
      messageId: data?['Id']
    );
  }
}
