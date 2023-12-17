
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/newmodels/message_model.dart';

class Room {
  String? sId;
  bool? isBizPage;
  bool? isMarketPlace;
  bool? isBroadCast;
  bool? isGroup;
  String? title;
  String? description;
  String? followers;
  String? following;
  String? pageId;
  String? ownerId;
  List<User>? people;
  List<String>? peopleIds;
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
      this.title,
      this.description,
      this.followers,
      this.following,
      this.pageId,
      this.ownerId,
      this.sId,
      this.people,
      this.isGroup,
      this.lastAuthor,
      this.lastMessage,
      this.lastMessageId,
      this.peopleIds,
      this.messages,
      this.timestamp,
      this.lastUpdate});

  Room.fromJson(Map<String, dynamic> json) {
    isBizPage = json['isBizPage'] is int ?  (json['isBizPage'] == 0 ? false : true) : json['isBizPage'];
    isMarketPlace = json['isMarketPlace'] is int ?  (json['isMarketPlace'] == 0 ? false : true) : json['isMarketPlace'];
    isBroadCast = json['isBroadCast'] is int ?  (json['isBroadCast'] == 0 ? false : true) : json['isBroadCast'];
    isGroup = json['isGroup'] is int ?  (json['isGroup'] == 0 ? false : true) : json['isGroup'];
    title = json['title'] == "" ? null : json['title'].toString();
    description = json['description'] == "" ? null : json['description'].toString();
    followers = json['followers'].toString();
    following = json['following'].toString();
    pageId = json['pageId'];
    ownerId = json['ownnerId'];
    sId = (json['_id']?? json['sId']).toString();
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
   lastAuthor = json['lastAuthor'].toString();
   lastMessageId = json['lastMessage'] != null ? json['lastMessage']['_id'] ?? "" : "";
    lastMessage = json['lastMessage'] != null ? Message.fromJson(json['lastMessage']) : null;
    lastUpdate = json['lastUpdate'];
    timestamp = json['lastUpdate'] ?? json['timestamp'];
    peopleIds = json['peopleIds'] != null ? json['peopleIds'].split(",") : [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isBizPage'] = this.isBizPage;
    data['isMarketPlace'] = this.isMarketPlace;
    data['isBroadCast'] = this.isBroadCast;
    data['title'] = this.title;
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
