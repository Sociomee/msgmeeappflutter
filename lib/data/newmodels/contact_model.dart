class ContactModel {
  List<MsgMeeContacts>? msgMeeContacts;
  List<int>? filteredContacts;

  ContactModel({this.msgMeeContacts, this.filteredContacts});

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['msgMeeContacts'] != null) {
      msgMeeContacts = <MsgMeeContacts>[];
      json['msgMeeContacts'].forEach((v) {
        msgMeeContacts!.add(new MsgMeeContacts.fromJson(v));
      });
    }
    filteredContacts = json['filteredContacts'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.msgMeeContacts != null) {
      data['msgMeeContacts'] =
          this.msgMeeContacts!.map((v) => v.toJson()).toList();
    }
    data['filteredContacts'] = this.filteredContacts;
    return data;
  }
}

class MsgMeeContacts {
  String? phone;
  String? sId;
  String? fullName;
  String? otherProfileImage;
  String? socioMeeId;
  String? username;
  String? linkedTo;

  MsgMeeContacts(
      {this.phone,
      this.sId,
      this.fullName,
      this.otherProfileImage,
      this.socioMeeId,
      this.username,
      this.linkedTo});

  MsgMeeContacts.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    sId = json['sId'];
    fullName = json['fullName'];
    otherProfileImage = json['otherProfileImage'];
    socioMeeId = json['socioMeeId'];
    username = json['username'];
    linkedTo = json['linkedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['sId'] = this.sId;
    data['fullName'] = this.fullName;
    data['otherProfileImage'] = this.otherProfileImage;
    data['socioMeeId'] = this.socioMeeId;
    data['username'] = this.username;
    data['linkedTo'] = this.linkedTo;
    return data;
  }
}
