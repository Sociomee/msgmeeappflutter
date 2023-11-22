class Config {
  String? userId;
  String? phone;
  bool? isSyncEnabled;
  String? syncedTill;

  Config({this.userId, this.phone, this.isSyncEnabled, this.syncedTill});

  Config.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    phone = json['phone'];
    isSyncEnabled = json['isSyncEnabled'] == 0 ? false : true;
    syncedTill = json['syncedTill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['isSyncEnabled'] = this.isSyncEnabled;
    data['syncedTill'] = this.syncedTill;
    return data;
  }
}
