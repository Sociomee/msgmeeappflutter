// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_contact_cubit.dart';



class ContactState {
  final List<Contact> contacts;
  final bool isLoading;
  final PermissionStatus permissionStatus;
  final List<PhoneBookUserModel> phonebookUser;

  ContactState({
    required this.contacts,
    required this.isLoading,
    required this.permissionStatus,
    required this.phonebookUser,
  });

  factory ContactState.initial() {
    return ContactState(
        contacts: [],
        isLoading: false,
        permissionStatus: PermissionStatus.denied,
        phonebookUser: []);
  }

  ContactState copyWith({
    List<Contact>? contacts,
    bool? isLoading,
    PermissionStatus? permissionStatus,
    List<PhoneBookUserModel>? phonebookUser,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      phonebookUser: phonebookUser ?? this.phonebookUser,
    );
  }
}
