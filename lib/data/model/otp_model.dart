class OtpModel {
  bool? success;
  String? successMessage;
  int? status;
  Data? data;

  OtpModel({this.success, this.successMessage, this.status, this.data});

  OtpModel.fromJson(Map<String, dynamic> json) {
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
  String? token;
  String? userId;
  String? userDeviceId;
  String? deviceId;

  Data({this.token, this.userId, this.userDeviceId, this.deviceId});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userId = json['userId'];
    userDeviceId = json['userDeviceId'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['userId'] = this.userId;
    data['userDeviceId'] = this.userDeviceId;
    data['deviceId'] = this.deviceId;
    return data;
  }
}