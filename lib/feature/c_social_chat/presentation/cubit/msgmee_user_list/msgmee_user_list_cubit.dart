import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:msgmee/data/model/check_msgmee_model.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/api_data_source/repository/user/user_repository.dart';
import 'package:msgmee/data/model/user_model.dart';
import 'package:msgmee/data/sqlite_data_source/repository/all_connections_repository.dart';
import 'package:msgmee/helper/string_ext.dart';
import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/model/phonebook_model.dart';
import '../../../../../data/api_data_source/repository/sociomee/sync_socimee_repository.dart';
import '../../../../../data/newmodels/contact_model.dart';
part 'msgmee_user_list_state.dart';

//flutter pub add flutter_libphonenumber
class MsgmeeUserListCubit extends Cubit<MsgmeeUserListState> {
  MsgmeeUserListCubit() : super(MsgmeeUserListState.initial());

  Future<void> getMsgmeeUsersList(
    List<PhoneBookUserModel> phonebookuser,
  ) async {
    log('getting msgmee users..');
    try {
      emit(state.copyWith(status: MsgmeeUserListStatus.loading));
      // var res = await UserSerivce().getFriendList(100, '');
      // List<User> msgmeeUserList = res.users!;
      // List<User> newUserList = [];
      

      //* Inserting data to the local sqlite database

      // log('new user $newUserList');
      // for (var i = 0; i < msgmeeUserList.length; i++) {
      //   await AllConnectionRepository().insertAllconnections(msgmeeUserList[i]);
      // }
      List<MsgMeeContacts> users = await AllConnectionRepository().getAllConnections();
      log('when database is empty${users}');
      emit(
        state.copyWith(
          status: MsgmeeUserListStatus.loaded,
          contactModel: ContactModel(msgMeeContacts: users , filteredContacts: state.contactModel.filteredContacts),
        ),
      );
      checkAndUpdateLocalContactDb(phonebookuser);
    } on CustomError catch (e) {
      emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
    }
  }

  Future<void> getdataLoaclData() async {
    return;
   // List<User> users = await AllConnectionRepository().getAllConnections();
    // emit(
    //   state.copyWith(
    //     status: MsgmeeUserListStatus.loaded,
    //     msgmeeUserList: MsgmeeUserList(
    //       limit: 0,
    //       search: '',
    //       users: users,
    //     ),
    //   ),
    // );
  }

  Future<void> getOverRiddedUsers({
    required List<PhoneBookUserModel> phonebookuser,
  }) async {
    return;
    // emit(state.copyWith(status: MsgmeeUserListStatus.loading));
    // try {
    //   var res = await UserSerivce().getFriendList(100, '');

    //   List<User> msgmeeUserList = res.users!;
    //   Set<User> msgmeeUserSet = Set.from(msgmeeUserList);
    //   List<User> finalUserList = [];
    //   List<String> nonMatchingPhoneNumbers = [];
    //   log('msgmee user set ---->$msgmeeUserSet');
    //   for (var pb in phonebookuser) {
    //     if (msgmeeUserSet.any((user) =>
    //         user.phone == pb.phone.removeFirstTwoCharsAndNormalize())) {
    //       User matchingUser = User(
    //         firstName: pb.name,
    //         phone: pb.phone,
    //       );

    //       finalUserList.add(matchingUser);
    //     } else {
    //       nonMatchingPhoneNumbers
    //           .add(pb.phone.removeFirstTwoCharsAndNormalize());
    //     }
    //   }
    //  // log('final userlist ---->$finalUserList');
    //   //log('final notmatching phone numbers ----->$nonMatchingPhoneNumbers');
    //   List<CheckMsgmeeModel> addmsgmeecontact = [];
    //   List<CheckMsgmeeModel> addcontact = [];
    //   if (nonMatchingPhoneNumbers.isNotEmpty) {
    //     for (var phone in nonMatchingPhoneNumbers) {
    //       var res = await SyncSocimeeService().checkMsgmee(phone);
    //       if (res.status == true) {
    //         addmsgmeecontact.add(res);
    //       } else if (res.status == false) {
    //         addcontact.add(res);
    //       }
    //     }
    //   }
    //   for (var e in addmsgmeecontact) {
    //    // log('addmsgmeecontact------->${e}');
    //     await SyncSocimeeService()
    //         .addContact(
    //       firstName: e.user!.firstName,
    //       lastName: e.user!.lastName,
    //       fullName: e.user!.fullName,
    //       msgmeeId: e.user!.sId,
    //       phone: e.user!.phone!,
    //       type: 'msgmee',
    //     )
    //         .then((value) {
    //       finalUserList.add(e.user!);
    //     });
    //   }
    //   for (var e in addcontact) {
    //    // log('addcontact------->${e}');
    //     await SyncSocimeeService().addContact(
    //       fullName: e.user!.fullName,
    //       phone: e.user!.phone!,
    //       type: 'contact',
    //     );
    //   }
    //  // log('final overRideduser $finalUserList');
    // } on CustomError catch (e) {
    //   emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
    // }
  }



  
  void checkAndUpdateLocalContactDb(List<PhoneBookUserModel> phonebookuser) async{
    print("contact length list ${phonebookuser.length}");

    var phoneNumbersList = phonebookuser.map((e) => e.phone).toList();
    print(phoneNumbersList);
    var res = await UserSerivce().getContactList(phoneNumbersList);
      List<MsgMeeContacts> msgmeeUserList = res.msgMeeContacts ?? [];
      List<User> newUserList = [];
      

     // * Inserting data to the local sqlite database

      print('new user ${res.msgMeeContacts!.length}');
      for (var map in msgmeeUserList) {
         await AllConnectionRepository().insertAllconnections(MsgMeeContacts(
          sId: map.sId,
          socioMeeId: map.socioMeeId,
          phone: map.phone,
          username: map.username,
          fullName: map.fullName,
          otherProfileImage: map.otherProfileImage,
          linkedTo: map.linkedTo,
        ));
      }
   

  }
}

//   Future<void> getMsgmeeUsersList(
//     List<PhoneBookUserModel> phonebookuser,
//   ) async {
//     try {
//       emit(state.copyWith(status: MsgmeeUserListStatus.loading));
//       var res = await UserSerivce().getFriendList(100, '');

//       // Sort the phonebookuser list based on phone numbers
//       phonebookuser.sort((a, b) =>
//           a.phone.toStandardFormat().compareTo(b.phone.toStandardFormat()));

//       List<User> msgmeeUserList = [];
//       msgmeeUserList.addAll(res.users!);

//       // Create a Set to keep track of processed phone numbers
//       Set<String> processedPhoneNumbers = Set<String>();

//       for (User msgmeeUser in msgmeeUserList) {
//         // Normalize the msgmeeUser phone number for comparison
         //String msgmeeUserPhone = (54858).phone!.toStandardFormat();

//         if (processedPhoneNumbers.contains(msgmeeUserPhone)) {
//           // Phone number has already been processed, skip
//           continue;
//         }

//         // Use binary search to find phone number in phonebookuser list
//         int index = binarySearch(phonebookuser, msgmeeUserPhone);

//         if (index != -1 && msgmeeUser.linkedTo == 'sociomee') {
//           // Phone number found in phonebookuser list
//           PhoneBookUserModel phoneBookUser = phonebookuser[index];
//           log('overriding sociomee user $msgmeeUserPhone');
//           msgmeeUser.fullName = phoneBookUser.name;
//           msgmeeUser.otherProfileImage = '';
//         } else {
//           log('calling check msgmee api');
//           await SyncSocimeeService().checkMsgmee(msgmeeUserPhone).then((value) {
//             if (value.status == true) {
//               // calling addcontact api
//               SyncSocimeeService().addContact(
//                 firstName: value.user!.firstName,
//                 lastName: value.user!.lastName,
//                 fullName: value.user!.fullName,
//                 msgmeeId: value.user!.sId,
//                 phone: value.user!.phone!,
//                 type: 'msgmee',
//               );
//               // Add the normalized phone number to the processed set
//               processedPhoneNumbers.add(msgmeeUserPhone);
//             } else if (value.status == false) {
//               SyncSocimeeService().addContact(
//                 fullName: value.user!.fullName,
//                 phone: value.user!.phone!,
//                 type: 'contact',
//               );
//             }
//           });
//         }
//       }

//       emit(
//         state.copyWith(
//           status: MsgmeeUserListStatus.loaded,
//           msgmeeUserList: MsgmeeUserList(
//             limit: res.limit,
//             search: res.search,
//             users: msgmeeUserList,
//           ),
//         ),
//       );
//     } on CustomError catch (e) {
//       emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
//     }
//   }

// // Binary search function
//   int binarySearch(List<PhoneBookUserModel> list, String targetPhone) {
//     int left = 0;
//     int right = list.length - 1;

//     while (left <= right) {
//       int mid = left + ((right - left) ~/ 2);
//       String midPhone = list[mid].phone.toStandardFormat();

//       if (midPhone == targetPhone) {
//         return mid; // Phone number found at index 'mid'
//       } else if (midPhone.compareTo(targetPhone) < 0) {
//         left = mid + 1;
//       } else {
//         right = mid - 1;
//       }
//     }

//     return -1; // Phone number not found
//   }

  // Future<void> getMsgmeeUsersList(
  //   List<PhoneBookUserModel> phonebookuser,
  // ) async {
  //   try {
  //     emit(state.copyWith(status: MsgmeeUserListStatus.loading));
  //     var res = await UserSerivce().getFriendList(100, '');

  //     // Create a HashMap to store phone numbers and corresponding user objects
  //     final phoneBookUserMap = HashMap<String, PhoneBookUserModel>();

  //     // Populate the HashMap with phone numbers from phonebookuser
  //     for (PhoneBookUserModel phoneBookUser in phonebookuser) {
  //       // Normalize the phone number by removing non-numeric characters
  //       String normalizedPhone = phoneBookUser.phone.toStandardFormat();
  //       phoneBookUserMap[normalizedPhone] = phoneBookUser;
  //     }

  //     List<User> msgmeeUserList = [];
  //     msgmeeUserList.addAll(res.users!);

  //     // Create a Set to keep track of processed phone numbers
  //     Set<String> processedPhoneNumbers = Set<String>();

  //     for (User msgmeeUser in msgmeeUserList) {
  //       // Normalize the msgmeeUser phone number for comparison
  //       String msgmeeUserPhone = msgmeeUser.phone!.toStandardFormat();

  //       if (processedPhoneNumbers.contains(msgmeeUserPhone)) {
  //         // Phone number has already been processed, skip
  //         continue;
  //       }

  //       PhoneBookUserModel? phoneBookUser = phoneBookUserMap[msgmeeUserPhone];

  //       if (phoneBookUser != null && msgmeeUser.linkedTo == 'sociomee') {
  //         // Phone number found in the HashMap and linked to sociomee
  //         log('overriding sociomee user $msgmeeUserPhone');
  //         msgmeeUser.fullName = phoneBookUser.name;
  //         msgmeeUser.otherProfileImage = '';
  //       } else {
  //         log('calling check msgmee api');
  //         await SyncSocimeeService().checkMsgmee(msgmeeUserPhone).then((value) {
  //           if (value.status == true) {
  //             // calling addcontact api
  //             SyncSocimeeService().addContact(
  //               firstName: value.user!.firstName,
  //               lastName: value.user!.lastName,
  //               fullName: value.user!.fullName,
  //               msgmeeId: value.user!.sId,
  //               phone: value.user!.phone!,
  //               type: 'msgmee',
  //             );
  //             // Add the normalized phone number to the processed set
  //             processedPhoneNumbers.add(msgmeeUserPhone);
  //           } else if (value.status == false) {
  //             SyncSocimeeService().addContact(
  //               fullName: value.user!.fullName,
  //               phone: value.user!.phone!,
  //               type: 'contact',
  //             );
  //           }
  //         });
  //       }
  //     }

  //     emit(
  //       state.copyWith(
  //         status: MsgmeeUserListStatus.loaded,
  //         msgmeeUserList: MsgmeeUserList(
  //           limit: res.limit,
  //           search: res.search,
  //           users: msgmeeUserList,
  //         ),
  //       ),
  //     );
  //   } on CustomError catch (e) {
  //     emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
  //   }
  // }

  // Future<void> getMsgmeeUsersList(
  //     List<PhoneBookUserModel> phonebookuser) async {
  //   try {
  //     emit(state.copyWith(status: MsgmeeUserListStatus.loading));
  //     var res = await UserSerivce().getFriendList(100, '');
  //     List<User> msgmeeUserList = res.users!;
  //     for (User msgmeeUser in msgmeeUserList) {
  //       for (PhoneBookUserModel phoneBookUser in phonebookuser) {
  //         log('overriding sociomee user ${msgmeeUser.phone == phoneBookUser.phone.toStandardFormat() && msgmeeUser.linkedTo == 'sociomee'}');
  //         if (msgmeeUser.phone == phoneBookUser.phone.toStandardFormat() &&
  //             msgmeeUser.linkedTo == 'sociomee') {
  //           msgmeeUser.fullName = phoneBookUser.name;
  //           msgmeeUser.otherProfileImage == '';
  //         } else {
  //           log('calling check msgmee api');
  //           await SyncSocimeeService()
  //               .checkMsgmee(phoneBookUser.phone.toStandardFormat())
  //               .then((value) {
  //             if (value.status == true) {
  //               //*calling addcontact api

  //               SyncSocimeeService().addContact(
  //                 firstName: value.user!.firstName,
  //                 lastName: value.user!.lastName,
  //                 fullName: value.user!.fullName,
  //                 msgmeeId: value.user!.sId,
  //                 phone: value.user!.phone!,
  //                 type: 'msgmee',
  //               );
  //             } else if (value.status == false) {
  //               SyncSocimeeService().addContact(
  //                 fullName: value.user!.fullName,
  //                 phone: value.user!.phone!,
  //                 type: 'contact',
  //               );
  //             }
  //           });
  //         }
  //       }
  //     }

  //     emit(
  //       state.copyWith(
  //         status: MsgmeeUserListStatus.loaded,
  //         msgmeeUserList: MsgmeeUserList(
  //             limit: res.limit, search: res.search, users: msgmeeUserList),
  //       ),
  //     );
  //   } on CustomError catch (e) {
  //     emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
  //   }
  // }

