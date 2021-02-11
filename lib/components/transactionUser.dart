import 'dart:math';

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
    ),
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
      id: Random().nextDouble.toString(),
      title: title,
      value: value,
      date: DateTime.now(),
    );
    setState(() {
      _transactions.add(newTransaction);
    });
  }
  //Quando uma transação for adicionada o metodo build (roda) vai atualizar e criar uma nova,o setState faz essa atualização

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      TransactionForm(
          _addTransaction), //Passando  de forma indireta (por meio de uma função) componente filho chama a função na hora certa
      TransactionList(
          _transactions), // Passando de forma direta pai passa dados diretos pro componente filho,
    ]);
  }
}
