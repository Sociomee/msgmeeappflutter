class SociomeeUserModel {
  bool? status;
  String? message;
  Data? data;
  IsMigratedOn? isMigratedOn;

  SociomeeUserModel({this.status, this.message, this.data, this.isMigratedOn});

  SociomeeUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    isMigratedOn = json['isMigratedOn'] != null
        ? new IsMigratedOn.fromJson(json['isMigratedOn'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.isMigratedOn != null) {
      data['isMigratedOn'] = this.isMigratedOn!.toJson();
    }
    return data;
  }
}

class Data {
  SuccessResult? successResult;

  Data({this.successResult});

  Data.fromJson(Map<String, dynamic> json) {
    successResult = json['successResult'] != null
        ? new SuccessResult.fromJson(json['successResult'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.successResult != null) {
      data['successResult'] = this.successResult!.toJson();
    }
    return data;
  }
}

class SuccessResult {
  String? userId;
  String? fullName;
  String? userName;
  String? profileImage;
  String? authToken;

  SuccessResult(
      {this.userId,
      this.fullName,
      this.userName,
      this.profileImage,
      this.authToken});

  SuccessResult.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    fullName = json['fullName'];
    userName = json['userName'];
    profileImage = json['profileImage'];
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['fullName'] = this.fullName;
    data['userName'] = this.userName;
    data['profileImage'] = this.profileImage;
    data['authToken'] = this.authToken;
    return data;
  }
}

class IsMigratedOn {
  String? sId;
  String? userId;
  String? key;
  String? createdAt;
  int? iV;

  IsMigratedOn({this.sId, this.userId, this.key, this.createdAt, this.iV});

  IsMigratedOn.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    key = json['key'];
    createdAt = json['createdAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['key'] = this.key;
    data['createdAt'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}
