import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Localdata {
  var storage = FlutterSecureStorage();

  void storedata(String key, String value) {
    storage.write(key: key, value: value);
  }

  readData(String key) async {
    String? data = await storage.read(key: key);
    return data;
  }

  void deleteData(String key) {
    storage.delete(key: key);
  }
}
