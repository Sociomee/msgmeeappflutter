import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

Future<List<Contact>> getContactData() async {
  PermissionStatus permissionStatus = await getContactPermission();

  if (permissionStatus == PermissionStatus.granted) {
    List<Contact> contacts = await FlutterContacts.getContacts();
    // ContactsService.getContacts();

    return contacts;
  } else {
    // _handleInvalidPermissions(permissionStatus, context);
    return [];
  }
}

Future<PermissionStatus> getContactPermission() async {
  PermissionStatus permission = await Permission.contacts.status;
  if (permission != PermissionStatus.granted &&
      permission != PermissionStatus.permanentlyDenied) {
    PermissionStatus permissionStatus = await Permission.contacts.request();
    return permissionStatus;
  } else {
    return permission;
  }
}

//!write this login in the ui file not here
// void _handleInvalidPermissions(
//     PermissionStatus permissionStatus, BuildContext context) {
//   if (permissionStatus == PermissionStatus.denied) {
//     final snackBar = SnackBar(content: Text('Access to contact data denied'));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
//     final snackBar =
//         SnackBar(content: Text('Contact data not available on device'));
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }

class ContactState {
  final List<Contact> contacts;
  final bool isLoading;
  final PermissionStatus permissionStatus;

  ContactState({
    required this.contacts,
    required this.isLoading,
    required this.permissionStatus,
  });

  factory ContactState.initial() {
    return ContactState(
      contacts: [],
      isLoading: false,
      permissionStatus: PermissionStatus.denied,
    );
  }

  ContactState copyWith({
    List<Contact>? contacts,
    bool? isLoading,
    PermissionStatus? permissionStatus,
  }) {
    return ContactState(
      contacts: contacts ?? this.contacts,
      isLoading: isLoading ?? this.isLoading,
      permissionStatus: permissionStatus ?? this.permissionStatus,
    );
  }
}

class ContactCubit extends Cubit<ContactState> {
  ContactCubit() : super(ContactState.initial());

  void fetchContacts() async {
    final permissionStatus = await Permission.contacts.status;
    if (!permissionStatus.isGranted) {
      final newStatus = await Permission.contacts.request();
      if (newStatus.isDenied || newStatus.isPermanentlyDenied) {
        emit(state.copyWith(permissionStatus: newStatus));
        return; // Exit if permission is denied or permanently denied
      }
    }

    emit(state.copyWith(isLoading: true));
    final contacts = await FlutterContacts.getContacts();
    emit(state.copyWith(contacts: contacts, isLoading: false));
  }
}
