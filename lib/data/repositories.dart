import 'dart:io';

import 'package:msgmee/data/model/chat_head_model.dart';
import 'package:msgmee/data/model/check_msgmee_model.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/model/interest_model.dart';
import 'package:msgmee/data/model/socimee_user_model.dart';

import 'model/msgmee_user_model.dart';
import 'model/sync_model.dart';

final String mainbaseUrl = 'https://api.sociomessage.com';

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<dynamic> verifyOtp(String phone, String otp);
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
  // Future<dynamic> getContactDetails();
  Future<dynamic> updateContact();
  Future<dynamic> getContactDetailsbyId();
  Future<dynamic> deleteContact();
}

abstract class AbChatHeadRepository {
  Future<ChatHeadModel> getChatHeadData();
}

abstract class AbSyncSociomeeRepository {
  Future<SociomeeUserModel> checkSocimeeAccount();
  Future<SyncModel> syncSocimee(int pageIndex);
  Future<CheckMsgmeeModel> checkMsgmee(String phone);
  Future addContact({
    String? firstName,
    String? lastName,
    required String phone,
    required String type,
    String? msgmeeId,
    String? fullName,
  });
}

abstract class AbDataSetsRepository {
  Future<InterestsModel> getinterests();
}

abstract class AbUserRepository {
  Future<MsgmeeUserModel> getUserData();
  Future<MsgmeeUserList> getFriendList(int limit, String search);
}
