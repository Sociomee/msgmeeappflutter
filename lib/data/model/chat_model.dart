class ChatMessage {
  final String messageContent;
  final String messageType;
  final String msgStatus;
  final String time;
  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.msgStatus,
    required this.time,
  });
}

List<ChatMessage> messages = [
  ChatMessage(
      messageContent: "Hello, Will",
      messageType: "receiver",
      msgStatus: 'read',
      time: '04.25 pm'),
  ChatMessage(
      messageContent: "How have you been?",
      messageType: "receiver",
      msgStatus: 'read',
      time: '04.25 pm'),
  ChatMessage(
      messageContent: "Hey Kriss, I am doing fine dude. wbu?",
      messageType: "sender",
      msgStatus: 'read',
      time: '04.25 pm'),
  ChatMessage(
      messageContent: "ehhhh, doing OK.",
      messageType: "receiver",
      msgStatus: 'read',
      time: '04.25 pm'),
  ChatMessage(
      messageContent: "Is there any thing wrong?",
      messageType: "sender",
      msgStatus: 'read',
      time: '04.25 pm'),
];
