import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:msgmee/feature/c_social_chat/presentation/cubit/msgmee_user_list/msgmee_user_list_cubit.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../../data/model/msgmee_user_model.dart';
import '../../../../../data/model/phonebook_model.dart';
import '../../../../../data/sqlite_data_source/sqlite_helper.dart';
part 'get_contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState.initial());
  //*********  handleing permission  *************//
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

  //*********  getting all the contacts  *************//
  Future<void> fetchContacts(MsgmeeUserListCubit msgmeecubit) async {
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
    await msgmeecubit.getMsgmeeUsersList(phoneBookList);
    getOverRidedContacts(msgmeecubit.state.msgmeeUserList.users!);
  }

  //*********  converting contact data to custom model class  *************//
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
        log('all phonebook contact${contact.displayName} : ${phone.value}');
      }
    }

    return phoneBookList;
  }

  //********* overriding contact after getting msgmeeuser data *************//
  void getOverRidedContacts(List<User> syncUserList) async {
    emit(state.copyWith(isLoading: true));
    final syncUserPhones = syncUserList
        .map((user) => user.phone!.removeFirstTwoCharsAndNormalize())
        .toSet();
    final overRidedSet = <String>{};
    final overRidedList = state.phonebookUser.where((phoneModel) {
      final phone = phoneModel.phone.removeFirstTwoCharsAndNormalize();
      if (!syncUserPhones.contains(phone) && overRidedSet.add(phone)) {
        return true;
      }
      return false;
    }).toList();
    log('Filterd contact list ${overRidedList}');
    await insertDataIfEmptyOrDifferent(SQLiteHelper().database, overRidedList);
    var data = await getDatabaseData();
    log('data before emiting--->${data.length}');
    emit(state.copyWith(phonebookUser: data, isLoading: false));
  }

  //********* getting contact data from local DB *************//
  Future<List<PhoneBookUserModel>> getDatabaseData() async {
    final db = await SQLiteHelper().database;
    final data = await getDataFromTable(db);
    return data;
  }
}

Future<void> insertDataIfEmptyOrDifferent(
    Database database, List<PhoneBookUserModel> newData) async {
  final db = await database;

  // Check if the table is empty
  final isEmpty = Sqflite.firstIntValue(
          await db.rawQuery('SELECT COUNT(*) FROM ${Tables.table1}')) ==
      0;

  if (isEmpty) {
    // Table is empty, insert new data
    await insertData(database, newData);
  } else {
    // Table is not empty, compare data
    final existingData = await getDataFromTable(database);

    if (!listsAreEqual(existingData, newData)) {
      // Data is different, insert new data
      await insertData(database, newData);
    }
  }
}

Future<List<PhoneBookUserModel>> getDataFromTable(Database database) async {
  final db = await database;
  final results = await db.query('${Tables.table1}');
  // Map the results to your data model
  return results.map((map) => PhoneBookUserModel.fromMap(map)).toList();
}

Future<void> insertData(
    Database database, List<PhoneBookUserModel> newData) async {
  final db = await database;

  // Clear existing data (optional, depends on your requirements)
  await db.delete('${Tables.table1}');

  // Insert new data
  for (var item in newData) {
    await db.insert('${Tables.table1}', item.toMap());
  }
}

bool listsAreEqual(
    List<PhoneBookUserModel> list1, List<PhoneBookUserModel> list2) {
  // Implement your logic to compare the two lists here
  // Return true if the lists are equal, otherwise return false
  // For example, you can compare the length and content of the lists
  return list1.length == list2.length &&
      list1.every((item) => list2.contains(item));
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
