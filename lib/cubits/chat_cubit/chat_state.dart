import 'package:chat_app/firestore/models/message.dart';

class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatSuccess extends ChatState {
  final List<Message> messages;

  ChatSuccess({required this.messages});
}
