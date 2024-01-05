class Producern {
  String? type;
  String? socketID;
  String? userID;
  String? roomID;
  String? producerID;
  String? sId;

  Producern(
      {this.type,
      this.socketID,
      this.userID,
      this.roomID,
      this.producerID,
      this.sId});

  Producern.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    socketID = json['socketID'];
    userID = json['userID'];
    roomID = json['roomID'];
    producerID = json['producerID'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['socketID'] = this.socketID;
    data['userID'] = this.userID;
    data['roomID'] = this.roomID;
    data['producerID'] = this.producerID;
    data['_id'] = this.sId;
    return data;
  }
}
