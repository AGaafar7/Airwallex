import 'package:flutter/material.dart';

class StartPaymentFlow extends StatefulWidget {
  const StartPaymentFlow({Key? key}) : super(key: key);

  @override
  State<StartPaymentFlow> createState() => _StartPaymentFlowState();
}

class _StartPaymentFlowState extends State<StartPaymentFlow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(
          Icons.close_rounded,
          color: Colors.deepPurple,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 22.0, top: 8.0),
        child: Column(
          children: [
            const Text(
              "Payment methods",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
