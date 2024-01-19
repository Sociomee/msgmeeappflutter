import 'package:msgmee/data/model/user_model.dart';

class Message {
  String? sId;
  int? id;
  User? author;
  String? authorId;
  String? content;
  String? room;
  String? date;
  int? status;
  int? isReply;
  String? replyContent;
  String? replyType;
  String? replyMsgId;
  int? msgNumber;
  int? isDeleted;
  String? sentTime;
  String? timestamp;
  String? type;

  Message(
      {this.sId,
      this.id,
      this.author,
      this.authorId,
      this.content,
      this.isReply,
      this.replyContent,
      this.replyType,
      this.replyMsgId,
      this.room,
      this.date,
      this.status,
      this.isDeleted,
      this.sentTime,
      this.type,
      this.msgNumber,
      this.timestamp});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? json['sId'];
    id = json['id'] ?? 0;
    author =
        json['author'] != null ? (json['author'] is String ? null:  new User.fromJson(json['author']) ) : null;
    authorId =
        json['author'] != null ? (json['author'] is String ? json['author'] :  json['author']['_id'] )  : (json['authorId'] ?? null);
    content = json['content'];
    room = json['room'];
    date = json['date'];
    status = json['status'] ?? 0;
    isDeleted = json['isDeleted'] ?? 0;

    isReply = (json['isReply'] is bool ? (json['isReply'] ? 1 : 0)  : json['isReply']) ?? 0;
    replyContent = json['replyContent'];
    replyType = json['replyType'];
    replyMsgId =  json['replyMsgId'];

    sentTime = json['sentTime'];
    timestamp = json['timestamp'];
    type = json['type'] ?? "text";
    msgNumber=json['msgNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['content'] = this.content;
    data['id'] = this.id ?? 0;
    data['room'] = this.room;
    data['date'] = this.date;
    data['status'] = this.status;
    data['isDeleted'] = this.isDeleted;
    data['sentTime'] = this.sentTime;
    data['timestamp'] = this.timestamp;
    data['type'] = this.type;
    data['msgNumber'] = this.msgNumber;
    return data;
  }
}