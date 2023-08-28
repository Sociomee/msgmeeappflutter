class MsgmeeContactModel {
  bool? success;
  int? status;
  List<Data>? data;

  MsgmeeContactModel({this.success, this.status, this.data});

  MsgmeeContactModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? contactUserId;
  String? userId;
  String? firstName;
  String? lastName;
  String? phone;
  bool? isDeleted;
  bool? isBlocked;
  int? iV;

  Data(
      {this.sId,
      this.contactUserId,
      this.userId,
      this.firstName,
      this.lastName,
      this.phone,
      this.isDeleted,
      this.isBlocked,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    contactUserId = json['contactUserId'];
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    isDeleted = json['isDeleted'];
    isBlocked = json['isBlocked'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['contactUserId'] = this.contactUserId;
    data['userId'] = this.userId;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['phone'] = this.phone;
    data['isDeleted'] = this.isDeleted;
    data['isBlocked'] = this.isBlocked;
    data['__v'] = this.iV;
    return data;
  }
}
