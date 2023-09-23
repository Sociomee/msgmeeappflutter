import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:msgmee/data/model/chat_head_model.dart';
import 'package:msgmee/data/repositories.dart';

import '../../../helper/local_data.dart';

class ChatHeadService extends AbChatHeadRepository {
  Dio dio = Dio();
  @override
  Future<ChatHeadModel> getChatHeadData() async {
    var userId = await Localdata().readData('userId');
    var token = await Localdata().readData('token');
    final response = await dio.get(
      '$mainbaseUrl/chats/heads',
      options: Options(headers: {
        "Authorization": "Bearer $token", "userid": userId
        // "Authorization":
        //     "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NGQ0YmQ2N2Y0ZDVhN2NjOGIxYzE3ZmYiLCJwaG9uZSI6Iis5MTczOTc4MDc5MzkiLCJ1c2VyRGV2aWNlSWQiOiI2NGUyMWI2MjQyYTA5ZjI4MTQyYTkxYTUiLCJkZXZpY2VJZCI6IjY0ZTIxYjYxNDJhMDlmMjgxNDJhOTFhMyIsImlzQWRtaW4iOmZhbHNlLCJpYXQiOjE2OTI1Mzk3NDYsImV4cCI6MTY5NTEzMTc0Nn0.1C7pdkY6DNNBkgwH_1W3cSJ4V_3J21XhS2rNh8Ny_Mw",
        // "userid": '64408a61ec90033b68bb42a2',
      }),
    );
    log('charhead data--->${response.data}');
    if (response.statusCode == 200) {
      var data = ChatHeadModel.fromJson(response.data);
      log('charhead data--->${response.data}');
      log('data-->${data.data!.chatHeads!.length}');
      return data;
    } else {
      return ChatHeadModel.fromJson(response.data);
    }
  }
}
