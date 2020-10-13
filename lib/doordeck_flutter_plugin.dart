import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DoordeckFlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('doordeck_flutter_plugin');

  static Future showUnlock() async {
    await _channel.invokeMethod("showUnlock");
  }

  static Future initDoordeck({
    @required String authToken,
    bool darkMode = false,
    bool closeButton = false,
  }) async {
    return await _channel.invokeMethod("initDoordeck", [authToken, darkMode, closeButton]);
  }

  static Future updateToken({@required String newAuthToken}) async {
    await _channel.invokeMethod("updateToken", [newAuthToken]);
  }

  static Future logout() async {
    await _channel.invokeMethod("logout");
  }
}
