class InterestsModel {
  bool? success;
  int? status;
  List<InterestData>? data;

  InterestsModel({this.success, this.status, this.data});

  InterestsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = <InterestData>[];
      json['data'].forEach((v) {
        data!.add(new InterestData.fromJson(v));
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

class InterestData {
  String? sId;
  String? name;
  String? icon;
  String? selectedIcon;

  InterestData({this.sId, this.name, this.icon, this.selectedIcon});

  InterestData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    icon = json['icon'];
    selectedIcon = json['selectedIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['selectedIcon'] = this.selectedIcon;
    return data;
  }
}
