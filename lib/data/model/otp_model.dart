class OtpModel {
  bool? status;
  String? message;
  String? data;
  String? userId;

  OtpModel({this.status, this.message, this.data , this.userId});

  OtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    data['userId'] = this.userId;
    return data;
  }
}

class OtpErrorModel {
  bool? status;
  String? message;
  List<String>? data;

  OtpErrorModel({this.status, this.message, this.data});

  OtpErrorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}
