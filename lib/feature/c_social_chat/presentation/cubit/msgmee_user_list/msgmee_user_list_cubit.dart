import 'dart:collection';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:msgmee/data/model/msgmee_user_model.dart';
import 'package:msgmee/data/repository/user/user_repository.dart';
import 'package:msgmee/helper/string_ext.dart';
import '../../../../../common_cubits/custom_error.dart';
import '../../../../../data/repository/sociomee/sync_socimee_repository.dart';
import '../get_contact/get_contact_cubit.dart';
part 'msgmee_user_list_state.dart';

class MsgmeeUserListCubit extends Cubit<MsgmeeUserListState> {
  MsgmeeUserListCubit() : super(MsgmeeUserListState.initial());

  Future<void> getMsgmeeUsersList(
    List<PhoneBookUserModel> phonebookuser,
  ) async {
    try {
      emit(state.copyWith(status: MsgmeeUserListStatus.loading));
      var res = await UserSerivce().getFriendList(100, '');

      // Create a HashSet to store phone numbers from phonebookuser for faster lookup
      final phoneBookUserSet = HashSet<String>();

      // Populate the HashSet with phone numbers from phonebookuser
      for (PhoneBookUserModel phoneBookUser in phonebookuser) {
        String normalizedPhone = phoneBookUser.phone.toStandardFormat();
        phoneBookUserSet.add(normalizedPhone);
      }

      List<User> msgmeeUserList = [];
      msgmeeUserList.addAll(res.users!);
      // Variables to track data size and filtered data size
      int totalDataSize = msgmeeUserList.length;
      int filteredDataSize = 0;
      for (User msgmeeUser in msgmeeUserList) {
        String msgmeeUserPhone = msgmeeUser.phone!.toStandardFormat();

        if (phoneBookUserSet.contains(msgmeeUserPhone) &&
            msgmeeUser.linkedTo == 'sociomee') {
          // Phone number found in phonebookuser HashSet and linked to sociomee
          log('overriding sociomee user $msgmeeUserPhone');
          PhoneBookUserModel phoneBookUser = phonebookuser.firstWhere(
            (user) => user.phone.toStandardFormat() == msgmeeUserPhone,
          );
          msgmeeUser.fullName = phoneBookUser.name;
          msgmeeUser.otherProfileImage = '';
          filteredDataSize++; // Increment filtered data size
        } else {
          log('calling check msgmee api');
          await SyncSocimeeService().checkMsgmee(msgmeeUserPhone).then((value) {
            if (value.status == true) {
              // calling addcontact api
              SyncSocimeeService().addContact(
                firstName: value.user!.firstName,
                lastName: value.user!.lastName,
                fullName: value.user!.fullName,
                msgmeeId: value.user!.sId,
                phone: value.user!.phone!,
                type: 'msgmee',
              );
              filteredDataSize++; // Increment filtered data size
            } else if (value.status == false) {
              SyncSocimeeService().addContact(
                fullName: value.user!.fullName,
                phone: value.user!.phone!,
                type: 'contact',
              );
            }
          });
        }
      }
// Calculate the percentage of filtered data
      double percentage = (filteredDataSize / totalDataSize) * 100;

      emit(
        state.copyWith(
          status: MsgmeeUserListStatus.loaded,
          msgmeeUserList: MsgmeeUserList(
            limit: res.limit,
            search: res.search,
            users: msgmeeUserList,
          ), // Include the percentage in the state
          filteredDataPercentage: percentage,
        ),
      );
    } on CustomError catch (e) {
      emit(state.copyWith(status: MsgmeeUserListStatus.error, error: e));
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
//         String msgmeeUserPhone = msgmeeUser.phone!.toStandardFormat();

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
}
