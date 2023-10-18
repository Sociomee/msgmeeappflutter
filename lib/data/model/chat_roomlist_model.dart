import 'local_room_model.dart';
import 'messages_model.dart';

class ChatRoomsModel {
  int? limit;
  List<ChatRooms>? rooms;

  ChatRoomsModel({this.limit, this.rooms});

  ChatRoomsModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    if (json['rooms'] != null) {
      rooms = <ChatRooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new ChatRooms.fromJson(v));
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

class ChatRooms {
  String? sId;
  List<People>? people;
  bool? isGroup;
  int? iV;
  String? lastAuthor;
  LastMessage? lastMessage;
  String? lastUpdate;

  ChatRooms(
      {this.sId,
      this.people,
      this.isGroup,
      this.iV,
      this.lastAuthor,
      this.lastMessage,
      this.lastUpdate});

  ChatRooms.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(new People.fromJson(v));
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
    data['_id'] = this.sId;
    if (this.people != null) {
      data['people'] = this.people!.map((v) => v.toJson()).toList();
    }
    data['isGroup'] = this.isGroup;
    data['__v'] = this.iV;
    data['lastAuthor'] = this.lastAuthor;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage!.toJson();
    }
    data['lastUpdate'] = this.lastUpdate;
    return data;
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

// class LastMessage {
//   String? sId;
//   String? author;
//   String? content;
//   String? room;
//   String? date;
//   int? iV;

//   LastMessage(
//       {this.sId, this.author, this.content, this.room, this.date, this.iV});

//   LastMessage.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     author = json['author'];
//     content = json['content'];
//     room = json['room'];
//     date = json['date'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['author'] = this.author;
//     data['content'] = this.content;
//     data['room'] = this.room;
//     data['date'] = this.date;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
