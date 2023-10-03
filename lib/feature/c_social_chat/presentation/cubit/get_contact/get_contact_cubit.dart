import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:msgmee/helper/string_ext.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../data/model/msgmee_user_model.dart';
part 'get_contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState.initial());

  void fetchContacts() async {
    final permissionStatus = await Permission.contacts.status;
    if (!permissionStatus.isGranted) {
      final newStatus = await Permission.contacts.request();
      if (newStatus.isDenied || newStatus.isPermanentlyDenied) {
        emit(state.copyWith(permissionStatus: newStatus));
        return;
      }
    }
    emit(state.copyWith(isLoading: true));
    final contacts = await ContactsService.getContacts();
    List<PhoneBookUserModel> phoneBookList = [];
    for (Contact contact in contacts) {
      for (Item phone in contact.phones!) {
        phoneBookList.add(
          PhoneBookUserModel(
            name: contact.displayName ?? "N/A",
            phone: phone.value ?? "N/A",
          ),
        );
        log('phonebookcontact---->>${contact.displayName}  : ${phone.value}');
      }
    }

    emit(state.copyWith(
        contacts: contacts, isLoading: false, phonebookUser: phoneBookList));
  }

  void getOverRidedContacts(List<User> syncUserList) {
    emit(state.copyWith(isLoading: true));
    //* Override phone numbers
    List<PhoneBookUserModel> overRidedList =
        state.phonebookUser.where((phoneModel) {
      log('standarded phone---->${phoneModel.phone.toStandardFormat()}');
      return !syncUserList
          .any((user) => phoneModel.phone.toStandardFormat() == user.phone);
    }).toList();
    emit(state.copyWith(phonebookUser: overRidedList, isLoading: false));
  }

  void searchContacts(String searchTerm) {
    if (searchTerm.isEmpty) {
    } else {}
  }
}
