class SociomeeAccountModel {
  bool? success;
  int? status;
  Data? data;

  SociomeeAccountModel({this.success, this.status, this.data});

  SociomeeAccountModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? userName;
  String? profileImageThumb;

  Data({this.id, this.userName, this.profileImageThumb});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    profileImageThumb = json['profileImageThumb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['profileImageThumb'] = this.profileImageThumb;
    return data;
  }
}
