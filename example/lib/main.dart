import 'package:flutter/material.dart';
import 'dart:async';

import 'package:airwallex/airwallex.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _token = "Awaiting Token";

  final _airwallex = Airwallex();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String token;

    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      //Choose the environment of the sdk one of those three: STAGING, DEMO, PRODUCTION
      //Choose the Component Provider from the sdk those are the three: CARD, REDIRECT, WECHAT
      await _airwallex.initialize(
        true,
        "DEMO",
        ["CARD", "REDIRECT"],
      );

      debugPrint(UniqueKey().toString());
      token = await _airwallex.login(
        "Your-ApiKey",
        "Your-ClientId",
      );
    } on PlatformException {
      token = "Failed to login to access the token";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _token = token;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Airwallex Plugin Example'),
        ),
        body: Center(
          child: Text("My Token: $_token"),
        ),
      ),
    );
  }
}
