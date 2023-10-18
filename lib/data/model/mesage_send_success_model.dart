// import 'messages_model.dart';

class MessageSendSuccessModel {
  SMessage? message;
  SRoom? room;

  MessageSendSuccessModel({this.message, this.room});

  MessageSendSuccessModel.fromJson(Map<String, dynamic> json) {
    message =
        json['message'] != null ? SMessage.fromJson(json['message']) : null;
    room = json['room'] != null ? SRoom.fromJson(json['room']) : null;
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

class SMessage {
  String? sId;
  SAuthor? author;
  String? content;
  String? room;
  String? date;
  int? iV;

  SMessage(
      {this.sId, this.author, this.content, this.room, this.date, this.iV});

  SMessage.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'] != null ? SAuthor.fromJson(json['author']) : null;
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

class SAuthor {
  String? sId;
  String? socioMeeId;
  String? firstName;
  String? level;
  String? phone;
  String? countryCode;
  String? lastName;
  String? username;
  String? fullName;
  String? otherProfileImage;
  String? role;
  String? linkedTo;
  List<String>? favorites;
  String? tagLine;
  List<String>? msgMeeContacts;
  List<String>? contacts;
  String? otp;
  String? lastOnline;
  Picture? picture;

  SAuthor(
      {this.sId,
      this.socioMeeId,
      this.firstName,
      this.level,
      this.phone,
      this.countryCode,
      this.lastName,
      this.username,
      this.fullName,
      this.otherProfileImage,
      this.role,
      this.linkedTo,
      this.favorites,
      this.tagLine,
      this.msgMeeContacts,
      this.contacts,
      this.otp,
      this.lastOnline,
      this.picture});

  SAuthor.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    socioMeeId = json['socioMeeId'];
    firstName = json['firstName'];
    level = json['level'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    lastName = json['lastName'];
    username = json['username'];
    fullName = json['fullName'];
    otherProfileImage = json['otherProfileImage'];
    role = json['role'];
    linkedTo = json['linkedTo'];
    favorites = json['favorites'].cast<String>();
    tagLine = json['tagLine'];
    msgMeeContacts = json['msgMeeContacts'].cast<String>();
    contacts = json['contacts'].cast<String>();
    otp = json['otp'];
    lastOnline = json['lastOnline'];
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['socioMeeId'] = this.socioMeeId;
    data['firstName'] = this.firstName;
    data['level'] = this.level;
    data['phone'] = this.phone;
    data['countryCode'] = this.countryCode;
    data['lastName'] = this.lastName;
    data['username'] = this.username;
    data['fullName'] = this.fullName;
    data['otherProfileImage'] = this.otherProfileImage;
    data['role'] = this.role;
    data['linkedTo'] = this.linkedTo;
    data['favorites'] = this.favorites;
    data['tagLine'] = this.tagLine;
    data['msgMeeContacts'] = this.msgMeeContacts;
    data['contacts'] = this.contacts;
    data['otp'] = this.otp;
    data['lastOnline'] = this.lastOnline;
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
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

  Picture(
      {this.sId,
      this.shield,
      this.name,
      this.author,
      this.size,
      this.iV,
      this.location,
      this.shieldedID});

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

class SRoom {
  String? sId;
  List<String>? people;
  bool? isGroup;
  int? iV;
  String? lastAuthor;
  String? lastMessage;
  String? lastUpdate;

  SRoom(
      {this.sId,
      this.people,
      this.isGroup,
      this.iV,
      this.lastAuthor,
      this.lastMessage,
      this.lastUpdate});

  SRoom.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    people = json['people'].cast<String>();
    isGroup = json['isGroup'];
    iV = json['__v'];
    lastAuthor = json['lastAuthor'];
    lastMessage = json['lastMessage'];
    lastUpdate = json['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['people'] = this.people;
    data['isGroup'] = this.isGroup;
    data['__v'] = this.iV;
    data['lastAuthor'] = this.lastAuthor;
    data['lastMessage'] = this.lastMessage;
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }
}









// class MessageSendSuccessModel {
//   Messages? message;
//   Room? room;

//   MessageSendSuccessModel({this.message, this.room});

//   MessageSendSuccessModel.fromJson(Map<String, dynamic> json) {
//     message =
//         json['message'] != null ?  Messages.fromJson(json['message']) : null;
//     room = json['room'] != null ?  Room.fromJson(json['room']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     if (this.message != null) {
//       data['message'] = this.message!.toJson();
//     }
//     if (this.room != null) {
//       data['room'] = this.room!.toJson();
//     }
//     return data;
//   }
// }

// class Message {
//   String? sId;
//   Author? author;
//   String? content;
//   String? room;
//   String? date;
//   int? iV;

//   Message({this.sId, this.author, this.content, this.room, this.date, this.iV});

//   Message.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     author =
//         json['author'] != null ? new Author.fromJson(json['author']) : null;
//     content = json['content'];
//     room = json['room'];
//     date = json['date'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     if (this.author != null) {
//       data['author'] = this.author!.toJson();
//     }
//     data['content'] = this.content;
//     data['room'] = this.room;
//     data['date'] = this.date;
//     data['__v'] = this.iV;
//     return data;
//   }
// }
