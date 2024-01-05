import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:mediasoup_client_flutter/mediasoup_client_flutter.dart';

class Peer {
  String? userID;
  String? socketID;
  User? user;

  Peer({this.userID, this.socketID, this.user});

  Peer.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    socketID = json['socketID'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['socketID'] = this.socketID;
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
  String? phone;
  String? countryCode;
  String? lastName;
  String? username;
  String? fullName;
  String? otherProfileImage;
  String? role;
  String? linkedTo;
  String? tagLine;
  String? otp;
  String? lastOnline;
  Picture? picture;

  User(
      {this.sId,
      this.email,
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
      this.tagLine,
      this.otp,
      this.lastOnline,
      this.picture});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
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
  
    tagLine = json['tagLine'];
    otp = json['otp'];
    lastOnline = json['lastOnline'];
    picture =
        json['picture'] != null ? new Picture.fromJson(json['picture']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
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
   
    data['tagLine'] = this.tagLine;
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

  Picture({this.isUrl, this.sId, this.shield});

  Picture.fromJson(Map<String, dynamic> json) {
    isUrl = json['isUrl'];
    sId = json['_id'];
    shield = json['shield'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUrl'] = this.isUrl;
    data['_id'] = this.sId;
    data['shield'] = this.shield;
    return data;
  }
}

