class SyncModel {
  bool? success;
  String? successMessage;
  int? status;
  dynamic data;

  SyncModel({this.success, this.successMessage, this.status, this.data});

  SyncModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    successMessage = json['successMessage'];
    status = json['status'];
    data = json['data'];
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

// class Data {


// 	Data({});

// 	Data.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		return data;
// 	}
// }
