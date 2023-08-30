import 'dart:io';

import 'package:msgmee/data/model/chat_head_model.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/model/otp_model.dart';

final String baseUrl = 'https://msgmee-node-docker-w0fh.onrender.com';
// 'https://msgmee-node-docker-w0fh.onrender.com';
//https://node.msgmee.sociomessages.com/
///

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<OtpModel> verifyOtp(String phone, String otp);
  Future<bool> createUser(String phone, String name, File image);
}

abstract class AbProfileRepository {
  Future<dynamic> updateUser(String userId, File image, String name);
}

abstract class AbContactRepository {
  Future<dynamic> createContact();
  Future<MsgmeeContactModel> getContacts();
  Future<dynamic> getContactDetails();
  Future<dynamic> updateContact();
  Future<dynamic> getContactDetailsbyId();
  Future<dynamic> deleteContact();
}

abstract class AbChatHeadRepository {
  Future<ChatHeadModel> getChatHeadData();
}
