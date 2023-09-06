class MsgmeeUserModel {
  bool? success;
  int? status;
  Data? data;

  MsgmeeUserModel({this.success, this.status, this.data});

  MsgmeeUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? phone;
  List<String>? interests;
  String? status;
  bool? isOnline;
  String? lastOnline;
  String? createdAt;
  String? updatedAt;
  String? registrationDate;
  String? lastLogin;
  int? iV;
  String? firstName;
  String? lastName;
  String? profilePic;
  String? bio;
  String? dob;
  String? gender;

  Data(
      {this.sId,
      this.phone,
      this.interests,
      this.status,
      this.isOnline,
      this.lastOnline,
      this.createdAt,
      this.updatedAt,
      this.registrationDate,
      this.lastLogin,
      this.iV,
      this.firstName,
      this.lastName,
      this.profilePic,
      this.bio,
      this.dob,
      this.gender});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    interests = json['interests'].cast<String>();
    status = json['status'];
    isOnline = json['isOnline'];
    lastOnline = json['lastOnline'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    registrationDate = json['registrationDate'];
    lastLogin = json['lastLogin'];
    iV = json['__v'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePic = json['profilePic'];
    bio = json['bio'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['interests'] = this.interests;
    data['status'] = this.status;
    data['isOnline'] = this.isOnline;
    data['lastOnline'] = this.lastOnline;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['registrationDate'] = this.registrationDate;
    data['lastLogin'] = this.lastLogin;
    data['__v'] = this.iV;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profilePic'] = this.profilePic;
    data['bio'] = this.bio;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}
