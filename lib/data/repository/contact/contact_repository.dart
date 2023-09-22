
import 'package:dio/dio.dart';
import 'package:msgmee/data/model/contact_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/helper/local_data.dart';

class ContactService extends AbContactRepository {
  Dio dio = Dio();
  var localdata = Localdata();
  @override
  Future createContact() {
    throw UnimplementedError();
  }

  @override
  Future deleteContact() {
    throw UnimplementedError();
  }



  @override
  Future getContactDetailsbyId() {
    throw UnimplementedError();
  }

  @override
  Future updateContact() {
    throw UnimplementedError();
  }

  @override
  Future<MsgmeeContactModel> getContacts() {
    
    throw UnimplementedError();
  }
}
