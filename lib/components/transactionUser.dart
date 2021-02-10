import 'package:flutter/material.dart';
import './transactionForm.dart';
import './transactionsList.dart';
import '../models/transactions.dart';

class TransactionUser extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<TransactionUser> {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Conta de Agua',
      value: 100.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Cinema',
      value: 30.50,
      date: DateTime.now(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[TransactionList(_transactions), TransactionForm()]);
  }
}
