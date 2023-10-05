import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../data/model/msgmee_user_model.dart';
part 'get_contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState.initial());

  Future<void> requestContactsPermission() async {
    final permissionStatus = await Permission.contacts.status;
    if (!permissionStatus.isGranted) {
      final newStatus = await Permission.contacts.request();
      if (newStatus.isDenied || newStatus.isPermanentlyDenied) {
        emit(state.copyWith(permissionStatus: newStatus));
        return;
      }
    }
  }

  void fetchContacts() async {
    await requestContactsPermission();
    emit(state.copyWith(isLoading: true));
    List<PhoneBookUserModel> phoneBookList = [];
    List<Contact>? contacts;
    try {
      contacts = await ContactsService.getContacts();
    } catch (e) {
      log('Error fetching contacts: $e');
    }

    phoneBookList = extractPhoneNumbers(contacts!);




    emit(state.copyWith(
      contacts: contacts,
      isLoading: false,
      phonebookUser: phoneBookList,
    ));
  }

  List<PhoneBookUserModel> extractPhoneNumbers(Iterable<Contact> contacts) {
    List<PhoneBookUserModel> phoneBookList = [];

    for (Contact contact in contacts) {
      for (Item phone in contact.phones ?? []) {
        phoneBookList.add(
          PhoneBookUserModel(
            name: contact.displayName ?? "N/A",
            phone: phone.value ?? "N/A",
          ),
        );
        log('phonebookcontact---->>${contact.displayName} : ${phone.value}');
      }
    }

    return phoneBookList;
  }






  //* contact overriding function
  void getOverRidedContacts(List<User> syncUserList) {
    emit(state.copyWith(isLoading: true));
    final syncUserPhones =
        syncUserList.map((user) => user.phone!.toStandardFormat()).toSet();

    final overRidedSet = <String>{};

    final overRidedList = state.phonebookUser.where((phoneModel) {
      final phone = phoneModel.phone.toStandardFormat();
      if (!syncUserPhones.contains(phone) && overRidedSet.add(phone)) {
        return true;
      }
      return false;
    }).toList();

    // final overRidedList = state.phonebookUser
    //     .where((phoneModel) {
    //       return !syncUserPhones.contains(phoneModel.phone.toStandardFormat());
    //     })
    //     .toSet()
    //     .toList();

    emit(state.copyWith(phonebookUser: overRidedList, isLoading: false));
  }

  void searchContacts(String searchTerm) {
    if (searchTerm.isEmpty) {
    } else {}
  }
}













//* first version of fetch function
// void fetchContacts() async {
//   final permissionStatus = await Permission.contacts.status;
//   if (!permissionStatus.isGranted) {
//     final newStatus = await Permission.contacts.request();
//     if (newStatus.isDenied || newStatus.isPermanentlyDenied) {
//       emit(state.copyWith(permissionStatus: newStatus));
//       return;
//     }
//   }
//   emit(state.copyWith(isLoading: true));
//   final contacts = await ContactsService.getContacts();
//   List<PhoneBookUserModel> phoneBookList = [];
//   for (Contact contact in contacts) {
//     for (Item phone in contact.phones!) {
//       phoneBookList.add(
//         PhoneBookUserModel(
//           name: contact.displayName ?? "N/A",
//           phone: phone.value ?? "N/A",
//         ),
//       );
//       log('phonebookcontact---->>${contact.displayName}  : ${phone.value}');
//     }
//   }

//   emit(state.copyWith(
//       contacts: contacts, isLoading: false, phonebookUser: phoneBookList));
// }

//* first version of contact override function
// void getOverRidedContacts(List<User> syncUserList) {
//   emit(state.copyWith(isLoading: true));

//   List<PhoneBookUserModel> overRidedList =
//       state.phonebookUser.where((phoneModel) {
//     return !syncUserList
//         .any((user) => phoneModel.phone.toStandardFormat() == user.phone);
//   }).toList();

//   emit(state.copyWith(phonebookUser: overRidedList, isLoading: false));
// }
