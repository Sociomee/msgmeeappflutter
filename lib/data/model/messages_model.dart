class MessagesModel {
  Room? room;

  MessagesModel({this.room});

  MessagesModel.fromJson(Map<String, dynamic> json) {
    room = json['room'] != null ? new Room.fromJson(json['room']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.room != null) {
      data['room'] = this.room!.toJson();
    }
    return data;
  }
}

class Room {
  String? sId;
  List<People>? people;
  bool? isGroup;
  String? lastUpdate;
  String? lastAuthor;
  String? lastMessage;
  List<Messages>? messages;
  List<String>? images;

  Room({
    this.sId,
    this.people,
    this.isGroup,
    this.lastUpdate,
    this.lastAuthor,
    this.lastMessage,
    this.messages,
    this.images,
  });

  Room.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    if (json['people'] != null) {
      people = <People>[];
      json['people'].forEach((v) {
        people!.add(People.fromJson(v));
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
}

class People {
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
  List<String>? msgMeeContacts;
  List<String>? contacts;
  String? otp;
  String? lastOnline;

  People(
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
      this.msgMeeContacts,
      this.contacts,
      this.otp,
      this.lastOnline});

  People.fromJson(Map<String, dynamic> json) {
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
    msgMeeContacts = json['msgMeeContacts'].cast<String>();
    contacts = json['contacts'].cast<String>();
    otp = json['otp'];
    lastOnline = json['lastOnline'];
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
    data['msgMeeContacts'] = this.msgMeeContacts;
    data['contacts'] = this.contacts;
    data['otp'] = this.otp;
    data['lastOnline'] = this.lastOnline;
    return data;
  }
}

class Messages {
  String? sId;
  Author? author;
  String? content;
  String? room;
  String? date;
  int? iV;

  Messages(
      {this.sId, this.author, this.content, this.room, this.date, this.iV});

  Messages.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
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

class Author {
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

  Author(
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
      this.lastOnline});

  Author.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
