import 'package:airwallex/payment_flow.dart';
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
        "8c347f4690b07653d3f0e8da09f629a9acfdaa4902ab138142333877bec089ebbb0c52ac1be7d754cd28a9a63878dd78",
        "MoNb7HuqT1msitP371PJ1A",
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
      home: HomeView(token: _token),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.token}) : super(key: key);
  final String token;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airwallex Plugin Example'),
      ),
      body: Center(
        child: Column(
          children: [
            ListView(shrinkWrap: true, children: [
              ListTile(
                title: Text("My Token: ${widget.token}",
                    style: const TextStyle(fontSize: 10)),
              )
            ]),
            ElevatedButton(
              onPressed: () async {
                // cus_hkdmt67bpgenvv8kly6
                //int_hkdmzbxgxgenw26xsiz
                //I need the threeDSMethodData from the confirmpaymentintent and then add it as a acs response in continue confirm payment intent
                //eyJ0aHJIZURTTWV0aG9kTm90aWZpY2F0aW9uVVJMljoiPHJldHVybl91cmw-liwidGhyZWVEU1NlcnZlclRyYW5zSUQiOilyMmE4YzNkZS1hN2FkLTQ5MTQtYjIZYS02NTU1M2QzYTI1ZTgifQ
                // ll = await Airwallex().continueConfirmPaymentIntent(
                //     widget.token, "int_hkdmt67bpgenil86kq6", {
                //   "request_id": "69a92dee-86d4-42d2-a553-a8d15cb628b3",
                //   "type": "3ds_continue",
                //   "three_ds": {
                //     "acs_response":
                //         "eyJ0aHJIZURTTWV0aG9kTm90aWZpY2F0aW9uVVJMljoiPHJldHVybl91cmw-liwidGhyZWVEU1NlcnZlclRyYW5zSUQiOilyMmE4YzNkZS1hN2FkLTQ5MTQtYjIZYS02NTU1M2QzYTI1ZTgifQ",
                //     "return_url": "http://www.merchant.com/3ds-result"
                //   }
                // });
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DDFrame(),
                  ),
                );*/
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StartPaymentFlow(
                      token: widget.token,
                      intentId: "int_hkdmt67bpgenil86kq6",
                    ),
                  ),
                );
              },
              child: const Text("Checkout"),
            ),
          ],
        ),
      ),
    );
  }
}
