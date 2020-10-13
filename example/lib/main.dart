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
    DoordeckFlutterPlugin.initDoordeck(
      authToken:
          "eyJraWQiOiJkZWZhdWx0IiwiYWxnIjoiRVMyNTYifQ.eyJzdWIiOiIxMzQ3N2M0MC0zMTUzLTExZWEtYTI4Yy0wYjJmOWQxMDUzNzUiLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwic2Vzc2lvbiI6IjU4ODM2ODkwLTA5NzYtMTFlYi05MzIwLWQ5MDI4YThjNTNiNCIsIm5hbWUiOiJSYWZhIiwiaXNzIjoiaHR0cHM6XC9cL2FwaS5kb29yZGVjay5jb21cLyIsInJlZnJlc2giOmZhbHNlLCJleHAiOjE2MDI1Nzk2OTcsImlhdCI6MTYwMjQ5MzI5NywiZW1haWwiOiJyYXJ1aXptdUBnbWFpbC5jb20iLCJzaWQiOiI1ODgzNjg5MC0wOTc2LTExZWItOTMyMC1kOTAyOGE4YzUzYjQifQ.11osq6m-mE5oZoNtPvQjO8Pi6gcLh2oJTKPBjALwkk93NkwSfUeUg6VQKON_8xELGfDmlvaZeGXAosvc2tg1EQ",
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
