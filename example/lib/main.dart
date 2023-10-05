import 'dart:io';

import 'package:doordeck_flutter_plugin/doordeck_flutter_plugin.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Replace with your token for this example
    String authToken = "";
    if (authToken.isEmpty) {
      throw Exception("Provide an API Key at _MyAppState.initState()");
    }
    DoordeckFlutterPlugin.initDoordeck(
      authToken: authToken,
      darkMode: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MaterialButton(
                  onPressed: DoordeckFlutterPlugin.showUnlock,
                  child: Text('Show unlock'),
                ),
                _buildUnlockByTileID(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnlockByTileID() {
    final TextEditingController textEditingController = TextEditingController();
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Enter your tile ID here (UUID)",
            ),
          ),
        ),
        MaterialButton(
          onPressed: () => _unlockTile(textEditingController.text),
          child: Icon(Icons.send),
        ),
      ],
    );
  }

  Future _unlockTile(String inputUUID) async {
    if (Platform.isAndroid) {
      DoordeckFlutterPlugin.unlockTileID(uuid: inputUUID);
    } else if (Platform.isIOS) {
      /// We must show our [QuickEntryViewController] anyhow in order to make this work.
      /// This is an accepted workaround at the moment
      DoordeckFlutterPlugin.showUnlock();
      await Future.delayed(Duration(seconds: 1));
      DoordeckFlutterPlugin.unlockTileID(uuid: inputUUID);
    } else {
      throw UnimplementedError("Not implemented for other platforms");
    }
  }
}
