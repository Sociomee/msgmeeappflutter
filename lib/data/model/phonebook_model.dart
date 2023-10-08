
import 'dart:convert';

class PhoneBookUserModel {
  final String name;
  final String phone;

  PhoneBookUserModel({required this.name, required this.phone});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phone': phone,
    };
  }

  factory PhoneBookUserModel.fromMap(Map<String, dynamic> map) {
    return PhoneBookUserModel(
      name: map['name'] as String,
      phone: map['phone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PhoneBookUserModel.fromJson(String source) =>
      PhoneBookUserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
