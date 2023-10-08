class MsgmeeUserModel {
  bool? status;
  User? user;

  MsgmeeUserModel({this.status, this.user});

  MsgmeeUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? email;
  String? socioMeeId;
  String? firstName;
  String? level;
  String? password;
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
  int? iV;
  String? otp;

  User(
      {this.sId,
      this.email,
      this.socioMeeId,
      this.firstName,
      this.level,
      this.password,
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
      this.iV,
      this.otp});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    socioMeeId = json['socioMeeId'];
    firstName = json['firstName'];
    level = json['level'];
    password = json['password'];
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
    iV = json['__v'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['socioMeeId'] = this.socioMeeId;
    data['firstName'] = this.firstName;
    data['level'] = this.level;
    data['password'] = this.password;
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
    data['__v'] = this.iV;
    data['otp'] = this.otp;
    return data;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'socioMeeId': socioMeeId,
      'firstName': firstName,
      'phone': phone,
      'lastName': lastName,
      'username': username,
      'fullName': fullName,
      'otherProfileImage': otherProfileImage,
      'linkedTo': linkedTo
    };
  }
}

class MsgmeeUserList {
  int? limit;
  String? search;
  List<User>? users;

  MsgmeeUserList({this.limit, this.search, this.users});

  MsgmeeUserList.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    search = json['search'];
    if (json['users'] != null) {
      users = <User>[];
      json['users'].forEach((v) {
        users!.add(new User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['search'] = this.search;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
