import 'dart:developer';

import 'package:flutter/services.dart';

class PlatformChannel {
  static const _channel = EventChannel("com.example.msgmee/smsStream");

  Stream smsStream() async* {
    yield* _channel.receiveBroadcastStream();
  }
}
