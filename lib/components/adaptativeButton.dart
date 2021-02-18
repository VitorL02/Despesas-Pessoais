import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdaptativeButton({this.label, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            color: Colors.deepPurple[800],
            child: Text(label,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(horizontal: 20),
          )
        : RaisedButton(
            color: Colors.deepPurple[800],
            textColor: Colors.white,
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: onPressed,
          );
  }
}
