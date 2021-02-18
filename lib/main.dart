import 'package:flutter/material.dart';
import 'components/transactionForm.dart';

import 'components/transactionsList.dart';
import 'models/transactions.dart';
import 'dart:math';
import './components/chart.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme:
          ThemeData(primarySwatch: Colors.deepPurple, fontFamily: 'Quicksand'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return TransactionForm(_addTransaction);
        });
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  final List<Transaction> _transactions = [];
  bool _showChart = false;

  //Filtrar as transações dos ultimos 7 dias
  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(newTransaction);
    });
    //Fecha o Formulario quando o submit e realizado
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    bool isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: <Widget>[
        if (isLandScape)
          IconButton(
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
            onPressed: () => {
              setState(() {
                _showChart = !_showChart;
              })
            },
          ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
      ],
      title: Text(
        'Despesas Pessoais',
        style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.bold,
          //Adapta a fonte de forma responsiva
          fontSize: 22 * MediaQuery.of(context).textScaleFactor,
        ),
      ),
      backgroundColor: Colors.deepPurple[800],
    );
    //Pega altura dinamicamente do dispositivo
    final avaliableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // if (isLandScape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Exibir Grafico'),
              //       Switch(
              //         value: _showChart,
              //         onChanged: (value) {
              //           setState(() {
              //             _showChart = value;
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              if (_showChart || !isLandScape)
                Container(
                  height: avaliableHeight * (isLandScape ? 0.7 : 0.3),
                  child: Chart(_recentTransactions),
                ),
              if (!_showChart || !isLandScape)
                Container(
                  height: avaliableHeight * (isLandScape ? 1 : 0.7),
                  child: TransactionList(_transactions, _deleteTransaction),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple[800],
          child: Icon(Icons.add),
          onPressed: () => _openTransactionFormModal(context),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
