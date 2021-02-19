import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class AdaptativeDataPicker extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateChange;
  AdaptativeDataPicker({this.selectedDate, this.onDateChange});

  _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateChange(pickedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            height: 180,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              minimumDate: DateTime(2019),
              maximumDate: DateTime.now(),
              onDateTimeChanged: onDateChange,
            ),
          )
        : Container(
            height: 60,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                      selectedDate == null
                          ? 'Nenhuma data selecionada'
                          : 'Data Selecionada ${DateFormat('EE dd/MM/y').format(selectedDate)}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontFamily: 'Raleway')),
                ),
                FlatButton(
                  textColor: Colors.purple[400],
                  child: Text(
                    'Selecionar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => _showDatePicker(context),
                )
              ],
            ),
          );
  }
}
