import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/check_msgmee_model.dart';
import 'package:msgmee/data/model/socimee_user_model.dart';
import 'package:msgmee/data/model/sync_model.dart';
import 'package:msgmee/data/api_data_source/repositories.dart';
import 'package:msgmee/data/api_data_source/repository/dio_provider.dart';
import 'package:msgmee/helper/local_data.dart';

class SyncSocimeeService extends AbSyncSociomeeRepository {
  var apiService = ApiService();
  var localData = Localdata();
  @override
  Future<SociomeeUserModel> checkSocimeeAccount() async {
    var token = await localData.readData('token');
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/check_sociomee',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      var res = SociomeeUserModel.fromJson(response.data);
      localData.storedata(
          'socimeetoken', res.data!.successResult!.authToken.toString());
      return res;
    } else {
      throw Exception();
    }
  }

  @override
  Future<SyncModel> syncSocimee(int pageIndex) async {
    var token = await localData.readData('token');
    var socimeeToken = await localData.readData('socimeetoken');
    final response = await apiService.dio.post(
      '$mainbaseUrl/api/sociomee_sync',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: {
        "token": socimeeToken,
        "pageIndex": pageIndex,
        "pageSize": 10,
      },
    );

    if (response.statusCode == 200) {
      var res = SyncModel.fromJson(response.data);
      return res;
    } else {
      throw Exception();
    }
  }

  @override
  Future addContact({
    String? firstName,
    String? lastName,
    required String phone,
    required String type,
    String? msgmeeId,
    String? fullName,
  }) async {
    var token = await localData.readData('token');

    var data = {
      "firstName": firstName ?? "",
      "lastName": lastName ?? "",
      "phone": phone,
      "type": type,
      "msgMeeId": msgmeeId ?? "",
      "fullName": fullName ?? "",
    };
    var response = await apiService.dio.post(
      '$mainbaseUrl/api/add-contact',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
      data: data,
    );
    // log('addcontact response---->${response.data}');
    if (response.statusCode == 200) {
      // log('add contact response----->${response.data}');
    }
  }

  @override
  Future<CheckMsgmeeModel> checkMsgmee(String phone) async {
    var token = await localData.readData('token');
    // log('sending contact phone for backend check $phone');
     return CheckMsgmeeModel();
    var response = await apiService.dio.post('$mainbaseUrl/api/checkMsgmee',
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
        data: {
          "phone": phone,
        });
    log('check phone: ${response.data['status'] == true}');
    if (response.statusCode == 200 && response.data['status'] == true) {
      var data = CheckMsgmeeModel.fromJson(response.data);
      return data;
    } else if (response.data['status'] == false) {
      return CheckMsgmeeModel();
    } else {
      throw Exception('getting error');
    }
  }

  @override
  Future<void> removeSocimee() async {
    var token = await localData.readData('token');
    var socimeeId = await localData.readData('userId');
    log('remove sociometes $socimeeId');
    var response =
        await apiService.dio.post('$mainbaseUrl/api/remove-sociomates',
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
              },
            ),
            data: {
          "userId": socimeeId,
        });
    log('remove sociometes ${response.data}');
  }
}
