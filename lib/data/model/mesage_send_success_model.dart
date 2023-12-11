// import 'messages_model.dart';

import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';

class MessageSendSuccessModel {
  Message? message;
  Room? room;

  MessageSendSuccessModel({this.message, this.room});

  MessageSendSuccessModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    room = json['room'] != null ? Room(): null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.message != null) {
      data['message'] = this.message!.toJson();
    }
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}