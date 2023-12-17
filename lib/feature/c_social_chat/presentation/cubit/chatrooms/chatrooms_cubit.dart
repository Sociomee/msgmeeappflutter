import 'dart:developer';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/api_data_source/repository/chat/chat_repository.dart';
import 'package:msgmee/data/newmodels/message_model.dart';
import 'package:msgmee/helper/local_data.dart';

import '../../../../../common_cubits/connectivity_cubit.dart';
import '../../../../../data/model/chat_roomlist_model.dart';
import '../../../../../data/model/create_room_model.dart';
import '../../../../../data/model/messages_model.dart';
import '../../../../../data/sqlite_data_source/repository/chat_rooms_repository.dart';
import '../../../../../data/sqlite_data_source/repository/messages_repository.dart';
import '../../../../../helper/connectivity_service.dart';

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
    var userId = await Localdata().readData('currentuserid');
    // log('cubit phone $phone\nauthorId $userId');
    print(userId);
    emit(state.copyWith(phone: phone, userId: userId));
  }

  void getUserId() async {
    
    var userId = await Localdata().readData('currentuserid');
    emit(state.copyWith(userId: userId));
  }

  //*** getting chat rooms list from server */
  void getchatroomsList() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    try {
     // var data = await ChatRepostory().getChatRoomList();
      // log('all rooms from remote server ${data.rooms!.length}');
      //insertDataToDB(data.rooms!);
     // emit(state.copyWith(response: data, status: ChatRoomStatus.loaded));
    } catch (e) {
      log('Error:$e');
    }
  }

  //***  inserting room data to local DB */
  void insertDataToDB(List<Room> rooms) async {
    // for (var e in rooms) {
    //   var room = Room(
    //     sId: e.sId,
    //     people: e.people,
    //     isGroup: e.isGroup.toString(),
    //     lastUpdate: e.lastUpdate,
    //     lastAuthor: e.lastAuthor,
    //     //lastMessage: e.lastMessage,
    //   );
    //   await ChatRoomsRepository().insertRooms(room);
    // }
  }

  //*** getting chat room data from localDB */
  void getLocalChatRoomData() async {
    emit(state.copyWith(status: ChatRoomStatus.loading));
    var res = await ChatRoomsRepository().getRooms();
    print('local chat rooms from db res--->${res.length}');
    emit(state.copyWith(chatroom: res, status: ChatRoomStatus.loaded));
  }

  Future<void> debugData() async {
   
    print("Querying rooms");
    var res = await ChatRoomsRepository().getRooms();
    log('local chat rooms from db res--->$res');
  }

  //***  getting chat room messages from server */
  Future<void> getchatRoomMessages({required String id}) async {
   // emit(state.copyWith(msgStatus: MessageStatus.loading ));
    try {
      final _connectivityService = ConnectivityService();
      bool isConnected = await _connectivityService.checkConnection();
      if(isConnected){
         var data = await ChatRepostory().getChatRoomMessages(id: id);
      emit(state.copyWith(messages: data, msgStatus: MessageStatus.loaded));
      //** insert message to localDB with seen status */
      insertMessagesToDB(data, 'seen');
      }
    } catch (e) {
      log('error while getting message $e');
    }
  }

  //***  inserting messages to local DB */
  Future<void> insertMessagesToDB(MessagesModel messages, String status) async {
    // var existingmessage = await MessagesRepository().getMessages();
    List message = [];
    // for (var e in messages.room!.messages!) {
    //   var localMessage = Message(
    //     sId: e.sId!,
    //     author: e.author!.sId!,
    //     file: '',
    //     room: e.room!,
    //     date: e.date!,
    //     content: e.content!,
    //     type: 'text',
    //     status: status,
    //   );
    //   message.add(localMessage);
    // }
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
    emit(state.copyWith(localmessage: message , currentRoomId : room));
  }


Future<void> getLocalDBMessagesByIdDebug(String room) async {
    await MessagesRepository().getDebugMessages(room);
    //emit(state.copyWith(localmessage: message));
  }

  //** create room function */
  Future<void> createchatRoom({required String userid}) async {
    emit(state.copyWith(createroomstatus: CreateRoomStatus.loading));
    try {
      print('create room response: ${userid}');
      var data = await ChatRepostory().createRoom(userid: userid);
      print('create room response: ${data.sId}');
      emit(state.copyWith(
          createroom: data, createroomstatus: CreateRoomStatus.loaded));
      
    } catch (e) {
      print('error while creating room:$e');
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
    
    var localData = Localdata();
    var authotCurrent = await localData.readData('currentuserid');
    var status = 0;
    var id = await MessagesRepository().insertSendMessages(Message(authorId: authotCurrent , room: roomId ,sId: "sId", content: content ,status: 0, type: contentType , date: DateTime.now().toString()));
    getLocalDBMessagesById(roomId);
    print("saved message id ${id}");
    // emit(state.copyWith(status: ChatRoomStatus.refresh));

      if (connectivityState.isOnline) {
        var sentToServer = await ChatRepostory().sendMessage(
      authorId: authotCurrent,
      roomId: roomId,
      content: content,
      contentType: contentType,
    );
      print('message send ${sentToServer.message}');
        print('message send');
        await MessagesRepository().updateMessage(sentToServer.message , id);
        print("Updated");
      } else {
        print('waiting');
       // await MessagesRepository().insertMessages(Message());
      }
      getLocalDBMessagesById(roomId);
  }

  //* sending message that has status "waiting" after connection restore
  Future<void> sendSavedMsg() async {
    log('sending saved messages...');
    var pendingMessages = await MessagesRepository().getPendingMessage();
    for (var e in pendingMessages) {
      var sentSuccessfully = await ChatRepostory().sendMessage(
        authorId: e.author?.sId ?? "",
        roomId: e.room??"",
        content: e.content,
        contentType: e.type ?? "text",
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

  String getCurrentRoomId() {
    return state.currentRoomId ?? "";
  }

  
}
