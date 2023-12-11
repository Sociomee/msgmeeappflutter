import 'package:msgmee/data/model/create_room_model.dart';


class ChatRoomsModel {
  int? limit;
  List<Room>? rooms;

  ChatRoomsModel({this.limit, this.rooms});

  ChatRoomsModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    if (json['rooms'] != null) {
      rooms = <Room>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
