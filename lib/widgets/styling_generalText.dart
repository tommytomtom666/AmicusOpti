import 'package:flutter/material.dart';

class GeneralText extends StatelessWidget {
  final String gText;

  GeneralText(this.gText);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        color: Colors.lime[300],
        child: Text(
          gText,
          style: TextStyle(fontSize: 12, color: Colors.black),
          textAlign: TextAlign.center,
        ));
  }
}
