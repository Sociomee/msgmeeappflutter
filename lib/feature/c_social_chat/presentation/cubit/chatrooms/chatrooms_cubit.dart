import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/helper/local_data.dart';

import '../../../../../data/model/chat_roomlist_model.dart';
import '../../../../../data/model/create_room_model.dart';
import '../../../../../data/model/messages_model.dart';
import '../../../../../data/sqlite_data_source/repository/chat_rooms_repository.dart';

part 'chatrooms_state.dart';

class ChatRoomsCubit extends Cubit<ChatRoomsState> {
  ChatRoomsCubit() : super(ChatRoomsState.initial());

  void getPhoneAndUserid() async {
    var phone = await Localdata().readData('phone');
    var userId = await Localdata().readData('userId');
    log('cubit phone $phone\nauthorId $userId');
    emit(state.copyWith(phone: phone, userId: userId));
  }

  void getchatroomsList() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    try {
      var data = await ChatRepostory().getChatRoomList();
      insertDataToDB(data.rooms!);
      emit(state.copyWith(response: data, status: ChatRoomStatus.loaded));
    } catch (e) {
      log('Error:$e');
    }
  }

//***  inserting room data to local DB */
  void insertDataToDB(List<ChatRooms> rooms) async {
    var existingRooms = await ChatRoomsRepository().getRooms();
    var currentRooms = rooms
        .map((e) => Room(
              sId: e.sId,
              people: e.people,
              isGroup: e.isGroup.toString(),
              lastUpdate: e.lastUpdate,
              lastAuthor: e.lastAuthor,
              lastMessage: e.lastMessage,
            ))
        .toList();
    bool dataIsDifferent = !listEquals(existingRooms, currentRooms);
    if (existingRooms.isEmpty && existingRooms.length == 0) {
      for (var e in rooms) {
        var room = Room(
          sId: e.sId,
          people: e.people,
          isGroup: e.isGroup.toString(),
          lastUpdate: e.lastUpdate,
          lastAuthor: e.lastAuthor,
          lastMessage: e.lastMessage,
        );
        await ChatRoomsRepository().insertRooms(room);
      }
    } else if (dataIsDifferent) {
      for (var e in rooms) {
        var room = Room(
          sId: e.sId,
          people: e.people,
          isGroup: e.isGroup.toString(),
          lastUpdate: e.lastUpdate,
          lastAuthor: e.lastAuthor,
          lastMessage: e.lastMessage,
        );

        await ChatRoomsRepository().deleteTable();
        await ChatRoomsRepository().insertRooms(room);
      }
    }
  }

//*** getting data from localDB */
  void getLocalChatRoomData() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    var res = await ChatRoomsRepository().getRooms();
    log('local db res--->$res');
    emit(state.copyWith(chatroom: res, status: ChatRoomStatus.loaded));
  }

  void getchatRoomMessages({required String id}) async {
    emit(state.copyWith(msgStatus: MessageStatus.loading));
    try {
      var data = await ChatRepostory().getChatRoomMessages(id: id);
      emit(state.copyWith(messages: data, msgStatus: MessageStatus.loaded));
    } catch (e) {
      log('error while getting message $e');
    }
  }

//** creatr room function */
  void createchatRoom({required String userid}) async {
    emit(state.copyWith(createroomstatus: CreateRoomStatus.loading));
    try {
      var data = await ChatRepostory().createRoom(userid: userid);
      log('create room response:${data} $userid');
      emit(state.copyWith(
          createroom: data, createroomstatus: CreateRoomStatus.loaded));
    } catch (e) {
      log('error while creating room:$e userid:$userid');
    }
  }

//**send message function */
  Future<void> sendMsg({
    required String authorId,
    required String roomId,
    required dynamic content,
    required String contentType,
  }) async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // Online: Send message to remote server
      var sentToServer = await ChatRepostory().sendMessage(
          authorId: authorId,
          roomId: roomId,
          content: content,
          contentType: contentType);

      if (sentToServer == 'true') {
        // update message table in local database
      } else {
        // Message failed to send to the server, handle error or retry later.
      }
    } else {
      // Offline: Store message in local database with "pending" status
    }
  }

  void sendMessage({
    required String authorId,
    required String roomId,
    required dynamic content,
    required String contentType,
  }) async {
    emit(state.copyWith(messageSendStatus: MessageSendStatus.loading));
    try {
      var data = await ChatRepostory().sendMessage(
          authorId: authorId,
          roomId: roomId,
          content: content,
          contentType: contentType);
      log('send message response:${data}');
      emit(state.copyWith(messageSendStatus: MessageSendStatus.loaded));
    } catch (e) {
      log('error while creating room:$e');
    }
  }
}
