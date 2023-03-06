import 'package:airwallex/airwallex.dart';
import 'package:airwallex/paymentmethods/payment_methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartPaymentFlow extends StatefulWidget {
  const StartPaymentFlow({
    Key? key,
    required this.token,
    required this.intentId,
  }) : super(key: key);
  final String token;
  final String intentId;
  @override
  State<StartPaymentFlow> createState() => _StartPaymentFlowState();
}

//Add different payment scenarios

class _StartPaymentFlowState extends State<StartPaymentFlow> {
  final _airwallex = Airwallex();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Payment methods",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: FutureBuilder(
                future: _airwallex.getConfigPaymentMethodTypes(
                    widget.token, null, null, null, null, null, null),
                builder: (context, AsyncSnapshot<Map> snapshot) {
                  List methodsCount = snapshot.data!.values.elementAt(1);
                  return ListView.builder(
                    itemCount:
                        methodsCount.map((e) => e['name']).toSet().length,
                    itemBuilder: (context, index) {
                      List<dynamic> paymentMethods =
                          snapshot.data!.values.elementAt(1);
                      debugPrint("QQQ $paymentMethods");

                      List paymentMethodName = [];

                      paymentMethodName
                          .addAll(paymentMethods.map((e) => e['name']).toSet());
                      debugPrint("LL ${paymentMethodName.toString()}");

                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (paymentMethodName[index] == "Card") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CardFlow(),
                                  ),
                                );
                              }
                            },
                            child: ListTile(
                              leading: paymentMethodIcon(
                                  paymentMethodName[index].toString()),
                              title: Text(
                                paymentMethodName[index].toString(),
                              ),
                            ),
                          ),
                          const Divider()
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Icon paymentMethodIcon(String paymentMethodName) {
    if (paymentMethodName == "card") {
      return const Icon(CupertinoIcons.creditcard);
    }
    return const Icon(Icons.abc);
  }
}
