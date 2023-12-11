import 'package:msgmee/data/model/picture_model.dart';

class User {
  String? sId;
  String? socioMeeId;
  String? firstName;
  String? level;
  String? phone;
  String? countryCode;
  String? lastName;
  String? username;
  String? email;
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

  User(
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
      this.email,
      this.msgMeeContacts,
      this.contacts,
      this.otp,
      this.lastOnline,
      this.picture});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    socioMeeId = json['socioMeeId'];
    firstName = json['firstName'];
    level = json['level'];
    phone = json['phone'];
    phone = json['email'];
    countryCode = json['countryCode'];
    lastName = json['lastName'];
    username = json['username'];
    fullName = json['fullName'];
    otherProfileImage = json['otherProfileImage'];
    role = json['role'];
    linkedTo = json['linkedTo'];
    favorites = [];
    tagLine = json['tagLine'];
    msgMeeContacts = [];
    contacts = [];
    otp = json['otp'];
    lastOnline = json['lastOnline'];
    picture =
        json['picture'] != null ? ((json['picture'] is String) ? null : new Picture.fromJson(json['picture'])) : null;
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
        data['email'] = this.email;
    data['tagLine'] = this.tagLine;
    data['msgMeeContacts'] = this.msgMeeContacts;
    data['otp'] = this.otp;
    data['lastOnline'] = this.lastOnline;
    if (this.picture != null) {
      data['picture'] = this.picture?.sId.toString();
    }
    return data;
  }
}
