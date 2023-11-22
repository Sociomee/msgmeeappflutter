class Room {
  bool? isBizPage;
  bool? isMarketPlace;
  bool? isBroadCast;
  String? description;
  String? followers;
  String? following;
  String? pageId;
  Null? ownnerId;
  String? sId;
  List<People>? people;
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
      this.ownnerId,
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
    ownnerId = json['ownnerId'];
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
    data['isBizPage'] = this.isBizPage;
    data['isMarketPlace'] = this.isMarketPlace;
    data['isBroadCast'] = this.isBroadCast;
    data['description'] = this.description;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['pageId'] = this.pageId;
    data['ownnerId'] = this.ownnerId;
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
  String? tagLine;
  List<String>? msgMeeContacts;
  List<Null>? contacts;
  String? otp;
  String? lastOnline;
  Picture? picture;

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
      this.tagLine,
      this.msgMeeContacts,
      this.contacts,
      this.otp,
      this.lastOnline,
      this.picture});

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
    tagLine = json['tagLine'];
    msgMeeContacts = json['msgMeeContacts'].cast<String>();
    if (json['contacts'] != null) {
      contacts = <Null>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Null.fromJson(v));
      });
    }
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
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    data['otp'] = this.otp;
    data['lastOnline'] = this.lastOnline;
    if (this.picture != null) {
      data['picture'] = this.picture!.toJson();
    }
    return data;
  }
}

class Picture {
  bool? isUrl;
  String? sId;
  String? shield;
  String? name;
  String? author;
  int? size;
  int? iV;
  String? location;
  String? shieldedID;

  Picture(
      {this.isUrl,
      this.sId,
      this.shield,
      this.name,
      this.author,
      this.size,
      this.iV,
      this.location,
      this.shieldedID});

  Picture.fromJson(Map<String, dynamic> json) {
    isUrl = json['isUrl'];
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
    data['isUrl'] = this.isUrl;
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
