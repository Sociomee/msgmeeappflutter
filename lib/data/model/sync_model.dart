class SyncModel {
  bool? status;
  String? message;
  bool? next;
  int? pageIndex;

  SyncModel({this.status, this.message, this.next, this.pageIndex});

  SyncModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    next = json['next'];
    pageIndex = json['pageIndex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['next'] = this.next;
    data['pageIndex'] = this.pageIndex;
    return data;
  }
}
