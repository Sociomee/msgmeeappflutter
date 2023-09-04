class MsgmeeUserModel {
  bool? success;
  String? successMessage;
  int? status;
  Data? data;

  MsgmeeUserModel({this.success, this.successMessage, this.status, this.data});

  MsgmeeUserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    successMessage = json['successMessage'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['successMessage'] = this.successMessage;
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
  bool? isOnline;
  String? lastOnline;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.phone,
      this.interests,
      this.isOnline,
      this.lastOnline,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    interests = json['interests'].cast<String>();
    isOnline = json['isOnline'];
    lastOnline = json['lastOnline'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['interests'] = this.interests;
    data['isOnline'] = this.isOnline;
    data['lastOnline'] = this.lastOnline;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
