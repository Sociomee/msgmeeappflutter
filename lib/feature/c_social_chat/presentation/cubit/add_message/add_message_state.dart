// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_message_cubit.dart';

class AddMessageState extends Equatable {
  final List<ChatMessage> messages;
  AddMessageState({required this.messages});


  factory AddMessageState.initial() {
    return AddMessageState(messages: [
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
    ]);
  }


  @override
  List<Object> get props => [messages];



  AddMessageState copyWith({
    List<ChatMessage>? messages,
  }) {
    return AddMessageState(
      messages: messages ?? this.messages,
    );
  }
}
