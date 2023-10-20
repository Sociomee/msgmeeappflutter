import 'dart:io';

import 'package:msgmee/data/model/chat_roomlist_model.dart';
import 'package:msgmee/data/model/check_msgmee_model.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/model/create_room_model.dart';
import 'package:msgmee/data/model/mesage_send_success_model.dart';
import 'package:msgmee/data/model/messages_model.dart';
import 'package:msgmee/data/model/socimee_user_model.dart';

import '../model/image_send_reponse_model.dart';
import '../model/msgmee_user_model.dart';
import '../model/sync_model.dart';

final String mainbaseUrl = 'https://api.msgmee.com';
// 'https://api.sociomessage.com';

abstract class AuthRepository {
  Future<bool> sendOtp(String phone);
  Future<dynamic> verifyOtp(String phone, String otp);
}

// abstract class AbProfileRepository {
//   Future<MsgmeeUserModel> updateUser(File image, String name);
//   Future<MsgmeeUserModel> updateBio(String bio);
//   Future<MsgmeeUserModel> updateDOB(String dob);
//   Future<MsgmeeUserModel> updateGender(String gender);
//   Future<MsgmeeUserModel> updateInterest(List<String> interest);
//   Future<MsgmeeUserModel> getUserDetails();
//   Future<MsgmeeUserModel> getUserDetailsByPhone(String phone);
// }

abstract class AbContactRepository {
  Future<dynamic> createContact();
  Future<MsgmeeContactModel> getContacts();
  Future<dynamic> updateContact();
  Future<dynamic> getContactDetailsbyId();
  Future<dynamic> deleteContact();
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

abstract class AbUserRepository {
  Future<MsgmeeUserModel> getUserData();
  Future<MsgmeeUserList> getFriendList(int limit, String search);
}

abstract class AbChatReporitory {
  Future<ChatRoomsModel> getChatRoomList();
  Future<MessagesModel> getChatRoomMessages({required String id});
  Future<CreateRoomModel> createRoom({required String userid});
  Future<MessageSendSuccessModel> sendMessage({
    required String authorId,
    required String roomId,
    required dynamic content,
    required String contentType,
  });
  Future<ImageSendResponseModel> sendImage(
      {required File imageFile, required String filename});
  Future<dynamic> typing(
      {required bool typing, required Map<String, dynamic> room});
}
