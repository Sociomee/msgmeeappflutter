class TypingStatus {
  String? id;
  String? roomID;
  bool? isTyping;

  TypingStatus({this.id, this.roomID, this.isTyping});

  TypingStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomID = json['roomID'];
    isTyping = json['isTyping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['roomID'] = this.roomID;
    data['isTyping'] = this.isTyping;
    return data;
  }
}
