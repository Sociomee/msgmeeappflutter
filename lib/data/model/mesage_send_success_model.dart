import 'messages_model.dart';

class MessageSendSuccessModel {
  Message? message;
  Room? room;

  MessageSendSuccessModel({this.message, this.room});

  MessageSendSuccessModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? new Message.fromJson(json['message']) : null;
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
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

class Message {
  String? sId;
  Author? author;
  String? content;
  String? room;
  String? date;
  int? iV;

  Message({this.sId, this.author, this.content, this.room, this.date, this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    content = json['content'];
    room = json['room'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
    data['room'] = this.room;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
