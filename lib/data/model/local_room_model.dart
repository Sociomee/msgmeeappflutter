import 'dart:convert';

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

class Picture {
  String? sId;
  String? shield;
  String? name;
  String? author;
  int? size;
  int? iV;
  String? location;
  String? shieldedID;

  Picture({
    this.sId,
    this.shield,
    this.name,
    this.author,
    this.size,
    this.iV,
    this.location,
    this.shieldedID,
  });

  Picture.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    shield = json['shield'];
    name = json['name'];
    author = json['author'];
    size = json['size'];
    iV = json['__v'];
    location = json['location'];
    shieldedID = json['shieldedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['shield'] = this.shield;
    data['name'] = this.name;
    data['author'] = this.author;
    data['size'] = this.size;
    data['__v'] = this.iV;
    data['location'] = this.location;
    data['shieldedID'] = this.shieldedID;
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
