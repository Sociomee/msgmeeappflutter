import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/data/model/local_message_model.dart';
import 'package:msgmee/helper/local_data.dart';

import '../../../../../common_cubits/connectivity_cubit.dart';
import '../../../../../data/model/chat_roomlist_model.dart';
import '../../../../../data/model/create_room_model.dart';
import '../../../../../data/model/local_room_model.dart';
import '../../../../../data/model/messages_model.dart';
import '../../../../../data/sqlite_data_source/repository/chat_rooms_repository.dart';
import '../../../../../data/sqlite_data_source/repository/messages_repository.dart';

part 'chatrooms_state.dart';

enum MessageSendingStatus {
  WAITINGFORNET, //*send from the user phone and store in local storage but did not to server
  SENT, //* send from the user phone and store in local storage and send to server
  DELIVERED, //* send from the phone and reciver also recieved the message
  SEEN, //* send from the phone and reciver also read the message
}

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsCubit() : super(ChatRoomsState.initial());
  //*** getting phone and userid from secure storage */
  void getPhoneAndUserid() async {
    var phone = await Localdata().readData('phone');
    var userId = await Localdata().readData('userId');
    // log('cubit phone $phone\nauthorId $userId');
    emit(state.copyWith(phone: phone, userId: userId));
  }

  //*** getting chat rooms list from server */
  void getchatroomsList() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    try {
      var data = await ChatRepostory().getChatRoomList();
      // log('all rooms from remote server ${data.rooms!.length}');
      //insertDataToDB(data.rooms!);
      emit(state.copyWith(response: data, status: ChatRoomStatus.loaded));
    } catch (e) {
      log('Error:$e');
    }
  }

  //***  inserting room data to local DB */
  void insertDataToDB(List<ChatRooms> rooms) async {
    for (var e in rooms) {
      var room = LocalChatRooms(
        sId: e.sId,
        people: e.people,
        isGroup: e.isGroup.toString(),
        lastUpdate: e.lastUpdate,
        lastAuthor: e.lastAuthor,
        lastMessage: e.lastMessage,
      );
      await ChatRoomsRepository().insertRooms(room);
    }
  }

  //*** getting chat room data from localDB */
  void getLocalChatRoomData() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    var res = await ChatRoomsRepository().getRooms();
    log('local chat rooms from db res--->$res');
    emit(state.copyWith(chatroom: res, status: ChatRoomStatus.loaded));
  }

  //***  getting chat room messages from server */
  Future<void> getchatRoomMessages({required String id}) async {
    emit(state.copyWith(msgStatus: MessageStatus.loading));
    try {
      var data = await ChatRepostory().getChatRoomMessages(id: id);
      emit(state.copyWith(messages: data, msgStatus: MessageStatus.loaded));
      //** insert message to localDB with seen status */
      insertMessagesToDB(data, 'seen');
    } catch (e) {
      log('error while getting message $e');
    }
  }

  //***  inserting messages to local DB */
  Future<void> insertMessagesToDB(MessagesModel messages, String status) async {
    // var existingmessage = await MessagesRepository().getMessages();
    List message = [];
    for (var e in messages.room!.messages!) {
      var localMessage = LocalMessagesModel(
        id: e.sId!,
        author: e.author!.sId!,
        file: '',
        room: e.room!,
        date: e.date!,
        content: e.content!,
        type: 'text',
        status: status,
      );
      message.add(localMessage);
    }
    for (var e in message) {
      await MessagesRepository().insertMessages(e);
    }
    // bool dataIsDifferent = !listEquals(existingmessage, message);
    // if (existingmessage.isNotEmpty && existingmessage.length == 0) {
    //   for (var e in message) {
    //     await MessagesRepository().insertMessages(e);
    //   }
    // } else if (dataIsDifferent) {
    //   log('data is different...');
    //   for (var e in message) {
    //     await MessagesRepository().insertMessages(e);
    //   }
    // }
  }

  //** getting messages from local DB */
  Future<void> getLocalDBMessages() async {
    var message = await MessagesRepository().getMessages();
    emit(state.copyWith(localmessage: message));
  }

  //**getting local message from local DB by roomId */
  Future<void> getLocalDBMessagesById(String room) async {
    var message = await MessagesRepository().getMessagesById(room);
    emit(state.copyWith(localmessage: message));
  }

  //** create room function */
  Future<void> createchatRoom({required String userid}) async {
    emit(state.copyWith(createroomstatus: CreateRoomStatus.loading));
    try {
      var data = await ChatRepostory().createRoom(userid: userid);
      log('create room response: ${data}');
      emit(state.copyWith(
          createroom: data, createroomstatus: CreateRoomStatus.loaded));
    } catch (e) {
      log('error while creating room:$e');
    }
  }

  //**send message function */
  Future<void> sendMsg({
    required String authorId,
    required String roomId,
    required dynamic content,
    required String contentType,
    required ConnectivityState connectivityState,
  }) async {
    
    var sentToServer = await ChatRepostory().sendMessage(
      authorId: authorId,
      roomId: roomId,
      content: content,
      contentType: contentType,
    );

    print('message send $sentToServer');
    emit(state.copyWith(status: ChatRoomStatus.refresh));
    if (connectivityState.result == ConnectivityResult.mobile ||
        connectivityState.result == ConnectivityResult.wifi) {
      log('connection ${connectivityState.isOnline}');

      // if (connectivityState.isOnline) {
      //   //* Device is online, perform actions accordingly.
      //   var sentToServer = await ChatRepostory().sendMessage(
      //     authorId: authorId,
      //     roomId: roomId,
      //     content: content,
      //     contentType: contentType,
      //   );
      //   log('message send $sentToServer');
      // } else {
      //   //* Offline: Store message in local database with "pending" status
      //   log('waiting');
      //   var message = LocalMessagesModel(
      //     id: '$roomId$authorId',
      //     author: authorId,
      //     file: '',
      //     room: roomId,
      //     date: DateTime.now().toString(),
      //     content: content,
      //     type: 'text',
      //     status: 'waiting',
      //   );
      //   await MessagesRepository().insertMessages(message);
      // }
      // var message = await MessagesRepository().getMessagesById(roomId);
      print("message send to server");
    }
  }

  //* sending message that has status "waiting" after connection restore
  Future<void> sendSavedMsg() async {
    log('sending saved messages...');
    var pendingMessages = await MessagesRepository().getPendingMessage();
    for (var e in pendingMessages) {
      var sentSuccessfully = await ChatRepostory().sendMessage(
        authorId: e.author,
        roomId: e.room,
        content: e.content,
        contentType: e.type,
      );

      if (sentSuccessfully.room != null) {
        MessagesRepository().updateDb('${e.room}${e.author}');
      }
    }
  }

  //* get online users data
  void updateUserList(List users) {
    emit(state.copyWith(onlineUsers: users));
  }

  void typing({required bool typing, required Map<String, dynamic> room}) {
    try {
      ChatRepostory().typing(typing: typing, room: room);
    } catch (e) {
      log('typing error $e');
    }
  }

  //* send image messages
  Future<void> sendImageMsg(
      {required File imageFile, required String filename}) async {
    try {
      await ChatRepostory().sendImage(imageFile: imageFile, filename: filename);
    } catch (e) {
      log('error sending message $e');
    }
  }

  
}
