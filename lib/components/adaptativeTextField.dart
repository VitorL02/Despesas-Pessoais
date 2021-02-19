import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptativeTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String labelText;
  final Function onSubmitted;

  AdaptativeTextField(
      {this.controller, this.keyboardType, this.labelText, this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              placeholder: labelText,
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 12,
              ),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(labelText: labelText),
          );
  }
}
