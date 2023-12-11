
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';

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
  String? lastMessageId;
  Message? lastMessage;
  List<Message>? messages;
  String? lastUpdate;
  String? timestamp;

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
      this.lastMessageId,
      this.messages,
      this.timestamp,
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
    
    if (json['messages'] != null) {
      messages = <Message>[];
      json['messages'].forEach((v) {
        messages!.add(new Message.fromJson(v));
      });
    }
    isGroup = json['isGroup'];
    iV = json['__v'];
    lastAuthor = json['lastAuthor'];
    lastMessageId = json['lastMessage'].isNotEmpty ? json['lastMessage']['_id'] ?? "" : "";
    lastMessage = json['lastMessage'].isNotEmpty ? Message.fromJson(json['lastMessage']) : null;
    lastUpdate = json['lastUpdate'];
    timestamp = json['lastUpdate'] ?? json['timestamp'];
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
      data['lastMessage'] = this.lastMessage;
    }
    data['lastUpdate'] = this.lastUpdate;
    return data;

  }
}
