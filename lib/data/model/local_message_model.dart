import 'dart:convert';

class LocalMessagesModel {
  final String id;
  final String author;
  final String file;
  final String room;
  final String date;
  final String content;
  final String type;
  final String status;

  LocalMessagesModel(
      {required this.id,
      required this.author,
      required this.file,
      required this.room,
      required this.date,
      required this.content,
      required this.type,
      required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'author': author,
      'file': file,
      'room': room,
      'date': date,
      'content': content,
      'type': type,
      'status': status,
    };
  }

  factory LocalMessagesModel.fromMap(Map<String, dynamic> map) {
    return LocalMessagesModel(
      id: map['id'] as String,
      author: map['author'] as String,
      file: map['file'] as String,
      room: map['room'] as String,
      date: map['date'] as String,
      content: map['content'] as String,
      type: map['type'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocalMessagesModel.fromJson(String source) =>
      LocalMessagesModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
