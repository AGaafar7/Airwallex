import 'package:flutter/material.dart';

class CardFlow extends StatefulWidget {
  const CardFlow({super.key});

  @override
  State<CardFlow> createState() => _CardFlowState();
}

class _CardFlowState extends State<CardFlow> {
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      builder: (BuildContext context) {
        return Container();
      },
      onClosing: () {},
    );
  }
}
