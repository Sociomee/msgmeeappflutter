class ImageSendResponseModel {
  int? status;
  Image? image;

  ImageSendResponseModel({this.status, this.image});

  ImageSendResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    return data;
  }
}

class Image {
  String? shield;
  String? name;
  String? author;
  int? size;
  String? sId;
  int? iV;
  String? location;
  String? shieldedID;

  Image(
      {this.shield,
      this.name,
      this.author,
      this.size,
      this.sId,
      this.iV,
      this.location,
      this.shieldedID});

  Image.fromJson(Map<String, dynamic> json) {
    shield = json['shield'];
    name = json['name'];
    author = json['author'];
    size = json['size'];
    sId = json['_id'];
    iV = json['__v'];
    location = json['location'];
    shieldedID = json['shieldedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shield'] = this.shield;
    data['name'] = this.name;
    data['author'] = this.author;
    data['size'] = this.size;
    data['_id'] = this.sId;
    data['__v'] = this.iV;
    data['location'] = this.location;
    data['shieldedID'] = this.shieldedID;
    return data;
  }
}















