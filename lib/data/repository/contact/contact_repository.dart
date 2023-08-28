import 'dart:developer';

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
  Future getContactDetails() {
    throw UnimplementedError();
  }

  @override
  Future getContactDetailsbyId() {
    throw UnimplementedError();
  }

  @override
  Future<MsgmeeContactModel> getContacts() async {
    //* var userId = await localdata.readData('userId');
    //* var token = await localdata.readData('token');
    var response = await dio.get(
      '$baseUrl/contacts?pageNumber=1&pageSize=15&isBlocked=false&populateContactUserId=false',
      options: Options(headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGUyMWI2MjQyYTA5ZjI4MTQyYTkxYTUiLCJkZXZpY2VJZCI6IjY0ZTIxYjYxNDJhMDlmMjgxNDJhOTFhMyIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI1Mzk3NDYsImV4cCI6MTY5NTEzMTc0Nn0.1C7pdkY6DNNBkgwH_1W3cSJ4V_3J21XhS2rNh8Ny_Mw",
        "userid": '64408a61ec90033b68bb42a2',
      }),
    );
    log('res---->$response');
    if (response.statusCode == 200) {
      var data = MsgmeeContactModel.fromJson(response.data);
      log('contact data--->${response.data}');
      log('data-->${data.data!.length}');
      return data;
    } else {
      return MsgmeeContactModel.fromJson(response.data);
    }
  }

  @override
  Future updateContact() {
    throw UnimplementedError();
  }
}
