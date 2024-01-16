// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chatrooms_cubit.dart';

enum ChatRoomStatus {
  initial,
  loading,
  loaded,
  error, 
  refresh,
}

enum MessageStatus {
  initial,
  loading,
  loaded,
  error,
}

enum CreateRoomStatus {
  initial,
  loading,
  loaded,
  error,
}

enum MessageSendStatus {
  initial,
  loading,
  loaded,
  error,
}

class ChatRoomsState extends Equatable {
  final ChatRoomsModel response;
  final ChatRoomStatus status;
  final MessagesModel messages;
  final MessageStatus msgStatus;
  final Room createroom;
  final User counterPartUser;
  final CreateRoomStatus createroomstatus;
  final MessageSendStatus messageSendStatus;
  final String? phone;
  final String? userId;
  final String? currentRoomId;
  final List<Room> chatroom;
  final List<Message> localmessage;
  final List onlineUsers;
  factory ChatRoomsState.initial() {
    return ChatRoomsState(
      response: ChatRoomsModel(),
      status: ChatRoomStatus.initial,
      messages: MessagesModel(),
      msgStatus: MessageStatus.initial,
      createroomstatus: CreateRoomStatus.initial,
      createroom: Room(),
      messageSendStatus: MessageSendStatus.initial,
      chatroom: [],
      counterPartUser : User(),
      localmessage: [],
      currentRoomId : null,
      onlineUsers: [],
    );
  }

  ChatRoomsState({
    required this.response,
    required this.status,
    required this.messages,
    required this.msgStatus,
    required this.createroomstatus,
    required this.createroom,
    required this.messageSendStatus,
    this.phone,
    this.userId,
    this.currentRoomId,
    required this.counterPartUser,
    required this.chatroom,
    required this.localmessage,
    required this.onlineUsers,
  });

  @override
  List<Object> get props => [
        response,
        status,
        messages,
        msgStatus,
        createroomstatus,
        createroom,
        counterPartUser,
        messageSendStatus,
        phone ?? '',
        userId ?? "",
        chatroom,
        localmessage,
        onlineUsers,
      ];

  ChatRoomsState copyWith({
    ChatRoomsModel? response,
    ChatRoomStatus? status,
    MessagesModel? messages,
    MessageStatus? msgStatus,
    Room? createroom,
    User? counterPartUser,
    CreateRoomStatus? createroomstatus,
    MessageSendStatus? messageSendStatus,
    String? phone,
    String? userId,
    String? currentRoomId,
    List<Room>? chatroom,
    List<Message>? localmessage,
    List? onlineUsers,
  }) {
    return ChatRoomsState(
      response: response ?? this.response,
      status: status ?? this.status,
      messages: messages ?? this.messages,
      msgStatus: msgStatus ?? this.msgStatus,
      createroom: createroom ?? this.createroom,
      createroomstatus: createroomstatus ?? this.createroomstatus,
      messageSendStatus: messageSendStatus ?? this.messageSendStatus,
      phone: phone ?? this.phone,
      userId: userId ?? this.userId,
      currentRoomId: userId ?? this.currentRoomId,
      chatroom: chatroom ?? this.chatroom,
      localmessage: localmessage ?? this.localmessage,
      counterPartUser: counterPartUser ?? this.counterPartUser,
      onlineUsers: onlineUsers ?? this.onlineUsers,
    );
  }
}
