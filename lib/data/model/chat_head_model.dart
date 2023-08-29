class ChatHeadModel {
  bool? success;
  int? status;
  Data? data;

  ChatHeadModel({this.success, this.status, this.data});

  ChatHeadModel.fromJson(Map<String, dynamic> json) {
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
  List<ChatHeads>? chatHeads;
  int? pageNumber;
  int? totalChatHeads;
  bool? allChatHeadsLoaded;

  Data(
      {this.chatHeads,
      this.pageNumber,
      this.totalChatHeads,
      this.allChatHeadsLoaded});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['chatHeads'] != null) {
      chatHeads = <ChatHeads>[];
      json['chatHeads'].forEach((v) {
        chatHeads!.add(new ChatHeads.fromJson(v));
      });
    }
    pageNumber = json['pageNumber'];
    totalChatHeads = json['totalChatHeads'];
    allChatHeadsLoaded = json['allChatHeadsLoaded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.chatHeads != null) {
      data['chatHeads'] = this.chatHeads!.map((v) => v.toJson()).toList();
    }
    data['pageNumber'] = this.pageNumber;
    data['totalChatHeads'] = this.totalChatHeads;
    data['allChatHeadsLoaded'] = this.allChatHeadsLoaded;
    return data;
  }
}

class ChatHeads {
  String? sId;
  String? name;
  String? displayPicture;
  String? phone;
  String? userId;
  bool? isOnline;
  String? chatRoomType;
  List<String>? isMuted;
  List<String>? isArchived;
  List<String>? isDeleted;
  List<String>? isPinned;
  List<String>? isRead;
  int? unreadMessageCount;
  String? updatedAt;
  String? latestMessage;
  String? latestMessageAt;
  String? lastOnline;
  String? description;
  bool? isAdmin;
  bool? isAdminRequiredToEdit;
  List<String>? participants;
  String? latestMessageFrom;
  String? creator;

  ChatHeads(
      {this.sId,
      this.name,
      this.displayPicture,
      this.phone,
      this.userId,
      this.isOnline,
      this.chatRoomType,
      this.isMuted,
      this.isArchived,
      this.isDeleted,
      this.isPinned,
      this.isRead,
      this.unreadMessageCount,
      this.updatedAt,
      this.latestMessage,
      this.latestMessageAt,
      this.lastOnline,
      this.description,
      this.isAdmin,
      this.isAdminRequiredToEdit,
      this.participants,
      this.latestMessageFrom,
      this.creator});

  ChatHeads.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    displayPicture = json['displayPicture'];
    phone = json['phone'];
    userId = json['userId'];
    isOnline = json['isOnline'];
    chatRoomType = json['chatRoomType'];
    isMuted = json['isMuted'].cast<String>();
    isArchived = json['isArchived'].cast<String>();
    isDeleted = json['isDeleted'].cast<String>();
    isPinned = json['isPinned'].cast<String>();
    isRead = json['isRead'].cast<String>();
    unreadMessageCount = json['unreadMessageCount'];
    updatedAt = json['updatedAt'];
    latestMessage = json['latestMessage'];
    latestMessageAt = json['latestMessageAt'];
    lastOnline = json['lastOnline'];
    description = json['description'];
    isAdmin = json['isAdmin'];
    isAdminRequiredToEdit = json['isAdminRequiredToEdit'];
    participants =
        json['participants'] == null ? [] : json['participants'].cast<String>();
    latestMessageFrom = json['latestMessageFrom'];
    creator = json['creator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['displayPicture'] = this.displayPicture;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    data['isOnline'] = this.isOnline;
    data['chatRoomType'] = this.chatRoomType;
    data['isMuted'] = this.isMuted;
    data['isArchived'] = this.isArchived;
    data['isDeleted'] = this.isDeleted;
    data['isPinned'] = this.isPinned;
    data['isRead'] = this.isRead;
    data['unreadMessageCount'] = this.unreadMessageCount;
    data['updatedAt'] = this.updatedAt;
    data['latestMessage'] = this.latestMessage;
    data['latestMessageAt'] = this.latestMessageAt;
    data['lastOnline'] = this.lastOnline;
    data['description'] = this.description;
    data['isAdmin'] = this.isAdmin;
    data['isAdminRequiredToEdit'] = this.isAdminRequiredToEdit;
    data['participants'] = this.participants;
    data['latestMessageFrom'] = this.latestMessageFrom;
    data['creator'] = this.creator;
    return data;
  }
}
