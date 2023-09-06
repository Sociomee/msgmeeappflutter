import 'dart:io';

import 'package:msgmee/data/model/chat_head_model.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/model/interest_model.dart';
import 'package:msgmee/data/model/otp_model.dart';
import 'package:msgmee/data/model/socimee_account_model.dart';

import 'model/msgmee_user_model.dart';
import 'model/sync_model.dart';

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
  Future<MsgmeeUserModel> updateUser(File image, String name);
  // Future<dynamic> updateUserName(String name);
  Future<MsgmeeUserModel> updateBio(String bio);
  Future<MsgmeeUserModel> updateDOB(String dob);
  Future<MsgmeeUserModel> updateGender(String gender);
  Future<MsgmeeUserModel> updateInterest(List<String> interest);

  Future<MsgmeeUserModel> getUserDetails();
  Future<MsgmeeUserModel> getUserDetailsByPhone(String phone);
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

abstract class AbSyncSociomeeRepository {
  Future<SociomeeAccountModel> getSocimeeAccount();
  Future<SyncModel> syncSocimee(String loginId, String password);
}

abstract class AbDataSetsRepository {
  Future<InterestsModel> getinterests();
}
