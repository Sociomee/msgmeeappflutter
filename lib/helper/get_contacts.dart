
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
