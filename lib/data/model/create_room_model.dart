import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/model/user_model.dart';

class Room {
  bool? isBizPage;
  bool? isMarketPlace;
  bool? isBroadCast;
  String? description;
  String? followers;
  String? following;
  String? pageId;
  String? ownerId;
  String? sId;
  List<User>? people;
  bool? isGroup;
  int? iV;
  String? lastAuthor;
  LastMessage? lastMessage;
  String? lastUpdate;

  Room(
      {this.isBizPage,
      this.isMarketPlace,
      this.isBroadCast,
      this.description,
      this.followers,
      this.following,
      this.pageId,
      this.ownerId,
      this.sId,
      this.people,
      this.isGroup,
      this.iV,
      this.lastAuthor,
      this.lastMessage,
      this.lastUpdate});

  Room.fromJson(Map<String, dynamic> json) {
    isBizPage = json['isBizPage'];
    isMarketPlace = json['isMarketPlace'];
    isBroadCast = json['isBroadCast'];
    description = json['description'];
    followers = json['followers'];
    following = json['following'];
    pageId = json['pageId'];
    ownerId = json['ownnerId'];
    sId = json['_id'];
    if (json['people'] != null) {
      people = <User>[];
      json['people'].forEach((v) {
        people!.add(new User.fromJson(v));
      });
    }
    isGroup = json['isGroup'];
    iV = json['__v'];
    lastAuthor = json['lastAuthor'];
    lastMessage = json['lastMessage'] != null
        ? new LastMessage.fromJson(json['lastMessage'])
        : null;
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isBizPage'] = this.isBizPage;
    data['isMarketPlace'] = this.isMarketPlace;
    data['isBroadCast'] = this.isBroadCast;
    data['description'] = this.description;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['pageId'] = this.pageId;
    data['ownnerId'] = this.ownerId;
    data['sId'] = this.sId;
    if (this.people != null) {
      data['people'] = this.people!.map((v) => v!.toJson()).toList();
    }
    data['isGroup'] = this.isGroup;
    data['lastAuthor'] = this.lastAuthor;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}




class LastMessage {
  String? sId;
  String? author;
  String? content;
  String? room;
  String? date;
  int? iV;

  LastMessage(
      {this.sId, this.author, this.content, this.room, this.date, this.iV});

  LastMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'];
    content = json['content'];
    room = json['room'];
    date = json['date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['author'] = this.author;
    data['content'] = this.content;
    data['room'] = this.room;
    data['date'] = this.date;
    data['__v'] = this.iV;
    return data;
  }
}
