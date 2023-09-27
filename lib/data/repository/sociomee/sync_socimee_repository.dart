import 'package:dio/dio.dart';
import 'package:msgmee/data/model/socimee_user_model.dart';
import 'package:msgmee/data/model/sync_model.dart';
import 'package:msgmee/data/repositories.dart';
import 'package:msgmee/data/repository/dio_provider.dart';
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
        "pageIndex": 0,
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
}
