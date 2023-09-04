import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/socimee_account_model.dart';
import 'package:msgmee/data/model/sync_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/helper/local_data.dart';

class SyncSocimeeService extends AbSyncSociomeeRepository {
  Dio dio = Dio();
  @override
  Future<SociomeeAccountModel> getSocimeeAccount() async {
    var response = await dio.get(
      '$baseUrl/sync/sociomee-account',
      options: Options(headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGUyMWI2MjQyYTA5ZjI4MTQyYTkxYTUiLCJkZXZpY2VJZCI6IjY0ZTIxYjYxNDJhMDlmMjgxNDJhOTFhMyIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI1Mzk3NDYsImV4cCI6MTY5NTEzMTc0Nn0.1C7pdkY6DNNBkgwH_1W3cSJ4V_3J21XhS2rNh8Ny_Mw",
        "userid": '64408a61ec90033b68bb42a2',
      }),
    );
    log('response--->${response.statusCode}\n${response.data}');
    if (response.statusCode == 200) {
      var res = SociomeeAccountModel.fromJson(response.data);
      log('res from service----->${res.data}');
      return res;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  @override
  Future<SyncModel> syncSocimee(String loginId, String password) async {
    var token = await Localdata().readData('token');
    log('token----->>$token');
    var response = await dio.post('$baseUrl/sync',
        data: {"loginId": loginId, "password": password},
        options: Options(headers: {
          "Authorization": "Bearer $token"
          // "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGUyMWI2MjQyYTA5ZjI4MTQyYTkxYTUiLCJkZXZpY2VJZCI6IjY0ZTIxYjYxNDJhMDlmMjgxNDJhOTFhMyIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI1Mzk3NDYsImV4cCI6MTY5NTEzMTc0Nn0.1C7pdkY6DNNBkgwH_1W3cSJ4V_3J21XhS2rNh8Ny_Mw",
        }));
    log('response ----->${response.statusCode}');
    if (response.statusCode == 200) {
      var res = SyncModel.fromJson(response.data);
      log('sync response---->$res');
      return res;
    } else {
      throw Exception(response.statusMessage);
    }
  }
}
