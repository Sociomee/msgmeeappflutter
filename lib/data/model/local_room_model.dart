import 'dart:convert';

import 'create_room_model.dart';
import 'messages_model.dart';

class LocalLocalChatRoomsModel {
  int? limit;
  List<LocalChatRooms>? rooms;

  LocalLocalChatRoomsModel({this.limit, this.rooms});

  LocalLocalChatRoomsModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    if (json['rooms'] != null) {
      rooms = <LocalChatRooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new LocalChatRooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocalChatRooms {
  String? sId;
  List<People>? people;
  String? isGroup;
  String? lastUpdate;
  String? lastAuthor;
  LastMessage? lastMessage;
  List<Messages>? messages;
  List<String>? images;

  LocalChatRooms({
    this.sId,
    this.people,
    this.isGroup,
    this.lastUpdate,
    this.lastAuthor,
    this.lastMessage,
    this.messages,
    this.images,
  });

  LocalChatRooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(new People.fromJson(v));
      });
    }
    isGroup = json['isGroup'];
    lastUpdate = json['lastUpdate'];
    lastAuthor = json['lastAuthor'];
    lastMessage = json['lastMessage'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.people != null) {
      data['people'] = this.people!.map((v) => v.toJson()).toList();
    }
    data['isGroup'] = this.isGroup;
    data['lastUpdate'] = this.lastUpdate;
    data['lastAuthor'] = this.lastAuthor;
    data['lastMessage'] = this.lastMessage;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    data['images'] = this.images;
    return data;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': sId,
      'people': jsonEncode(people),
      'title': '',
      'picture': '',
      'isGroup': isGroup,
      'lastUpdate': lastUpdate,
      'lastAuthor': lastAuthor,
      'lastMessage': jsonEncode(lastMessage!.toJson()),
    };
  }
}
