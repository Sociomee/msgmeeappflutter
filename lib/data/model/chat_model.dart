// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:msgmee/feature/c_social_chat/presentation/pages/chat_screen/widgets/message_type.dart';

class ChatMessage {
  final String messageContent;
  final String messageType;
  final String msgStatus;
  final String time;
  final MessageType type;
  final File? image_url;
  final String? docName;
  final List<File?>? images;
  final List<String>? docs;
  final int? numberofContact;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.msgStatus,
    required this.time,
    required this.type,
    this.image_url,
    this.docName,
    this.images,
    this.docs,
    this.numberofContact,
  });
}

List<ChatMessage> messages = [
  ChatMessage(
    messageContent: "Hello, Will",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "How have you been?",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Hey Kriss, I am doing fine dude. wbu?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "ehhhh, doing OK.",
    messageType: "receiver",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
  ChatMessage(
    messageContent: "Is there any thing wrong?",
    messageType: "sender",
    msgStatus: 'read',
    time: '04.25 pm',
    type: MessageType.text,
  ),
];
