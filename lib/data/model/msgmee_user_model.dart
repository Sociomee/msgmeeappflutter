import 'package:msgmee/data/model/user_model.dart';

class MsgmeeUserModel {
  bool? status;
  User? user;

  MsgmeeUserModel({this.status, this.user});

  MsgmeeUserModel.fromJson(Map<String, dynamic> json) {
    status = false;//json['status'];
    user = null; //json['user'] != null ? new User.fromJson(json['user']) : null;
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
        users!.add(User.fromJson(v));
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
