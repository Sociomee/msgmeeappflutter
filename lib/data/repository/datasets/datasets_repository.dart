import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/interest_model.dart';
import 'package:msgmee/data/repositories.dart';

import '../../../helper/local_data.dart';

class DataSets extends AbDataSetsRepository {
  Dio dio = Dio();
  @override
  Future<InterestsModel> getinterests() async {
    var token = await Localdata().readData('token');
    final response = await dio.get(
      '$baseUrl/datasets/interests',
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );
    log('interests--->$response');
    if (response.statusCode == 200) {
      var res = response.data;
      var data = InterestsModel.fromJson(res);
      log('interests--->$data');
      return data;
    } else {
      return InterestsModel.fromJson(response.data);
    }
  }
}
