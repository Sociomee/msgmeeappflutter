class Picture {
  bool? isUrl;
  String? sId;
  String? shield;
  String? name;
  String? author;
  int? size;
  String? location;
  String? shieldedID;

  Picture(
      {this.isUrl,
      this.sId,
      this.shield,
      this.name,
      this.author,
      this.size,
      this.location,
      this.shieldedID});

  Picture.fromJson(Map<String, dynamic> json) {
    isUrl = json['isUrl'];
    sId = json['_id'];
    shield = json['shield'];
    name = json['name'];
    author = json['author'];
    size = json['size'];
    location = json['location'];
    shieldedID = json['shieldedID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isUrl'] = this.isUrl;
    data['_id'] = this.sId;
    data['shield'] = this.shield;
    data['name'] = this.name;
    data['author'] = this.author;
    data['size'] = this.size;
    data['location'] = this.location;
    data['shieldedID'] = this.shieldedID;
    return data;
  }
}