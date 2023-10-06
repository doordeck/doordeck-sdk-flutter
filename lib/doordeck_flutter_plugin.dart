import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

class DoordeckFlutterPlugin {
  static const MethodChannel _channel = const MethodChannel('doordeck_flutter_plugin');

  static Future showUnlock() async {
    await _channel.invokeMethod("showUnlock");
  }

  static Future initDoordeck({
    required String authToken,
    bool darkMode = false,
    bool closeButton = false,
  }) async {
    return await _channel.invokeMethod("initDoordeck", [authToken, darkMode, closeButton]);
  }

  static Future updateToken({required String newAuthToken}) async {
    await _channel.invokeMethod("updateToken", [newAuthToken]);
  }

  static Future unlockTileID({required String uuid}) async {
    if (Platform.isAndroid) {
      await _channel.invokeMethod("unlockTileID", [uuid]);
    } else {
      /// We must show our [QuickEntryViewController] anyhow in order to make this work.
      /// This is an accepted workaround at the moment
      showUnlock();
      await Future.delayed(Duration(seconds: 1));
      await _channel.invokeMethod("unlockTileID", [uuid]);
    }
  }

  static Future logout() async {
    await _channel.invokeMethod("logout");
  }
}
