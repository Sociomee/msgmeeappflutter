import 'package:msgmee/data/model/user_model.dart';

import 'msgmee_user_model.dart';

class CheckMsgmeeModel {
  bool? status;
  String? message;
  User? user;

  CheckMsgmeeModel({this.status, this.message, this.user});

  CheckMsgmeeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}
