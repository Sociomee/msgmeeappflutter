// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chatrooms_cubit.dart';

enum ChatRoomStatus {
  initial,
  loading,
  loaded,
  error,
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
  final CreateRoomModel createroom;
  final CreateRoomStatus createroomstatus;
  final MessageSendStatus messageSendStatus;
  final String? phone;
  final String? userId;
  final List<LocalChatRooms> chatroom;
  final List<LocalMessagesModel> localmessage;
  final List onlineUsers;
  factory ChatRoomsState.initial() {
    return ChatRoomsState(
      response: ChatRoomsModel(),
      status: ChatRoomStatus.initial,
      messages: MessagesModel(),
      msgStatus: MessageStatus.initial,
      createroomstatus: CreateRoomStatus.initial,
      createroom: CreateRoomModel(),
      messageSendStatus: MessageSendStatus.initial,
      chatroom: [],
      localmessage: [],
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
    CreateRoomModel? createroom,
    CreateRoomStatus? createroomstatus,
    MessageSendStatus? messageSendStatus,
    String? phone,
    String? userId,
    List<LocalChatRooms>? chatroom,
    List<LocalMessagesModel>? localmessage,
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
      chatroom: chatroom ?? this.chatroom,
      localmessage: localmessage ?? this.localmessage,
      onlineUsers: onlineUsers ?? this.onlineUsers,
    );
  }
}
