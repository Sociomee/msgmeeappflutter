import 'dart:convert';

import 'package:dio/dio.dart';

import '../const/const.dart';

Future<dynamic> userLogin(String email) async {
  Dio dio = Dio();

  try {
    Response response = await dio.post('$baseUrl/public/loginWithMessagmee',
        data: json.encode({"email": email}));

    print(response);
    return response.data;
  } catch (e) {
    print('error-->$e');
  }
}