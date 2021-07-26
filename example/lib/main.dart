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
            child: RaisedButton(
          onPressed: () {
            DoordeckFlutterPlugin.showUnlock();
          },
          child: Text('Show unlock'),
        )),
      ),
    );
  }
}
