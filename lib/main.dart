import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'components/transactionForm.dart';

import 'components/transactionsList.dart';
import 'models/transactions.dart';
import 'dart:math';
import 'dart:io';
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

//Metodo que permite identificar  os icones de cada Plataforma
  Widget _getIconButton(IconData icon, Function fn) {
    return Platform.isIOS
        ? GestureDetector(onTap: fn, child: Icon(icon))
        : IconButton(icon: Icon(icon), onPressed: fn);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandScape = mediaQuery.orientation == Orientation.landscape;
    final actions = <Widget>[
      if (isLandScape)
        _getIconButton(
          _showChart ? Icons.list : Icons.show_chart,
          () {
            setState(() {
              _showChart = !_showChart;
            });
          },
        ),
      _getIconButton(
        Platform.isIOS ? CupertinoIcons.add : Icons.add,
        () => _openTransactionFormModal(context),
      ),
    ];
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas Pessoais'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            actions: actions,
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                //Adapta a fonte de forma responsiva
                fontSize: 22 * mediaQuery.textScaleFactor,
              ),
            ),
            backgroundColor: Colors.deepPurple[800],
          );
    //Pega altura dinamicamente do dispositivo
    final avaliableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;
    final bodyPage = SingleChildScrollView(
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
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appBar,
            body: bodyPage,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    backgroundColor: Colors.deepPurple[800],
                    child: Icon(Icons.add),
                    onPressed: () => _openTransactionFormModal(context),
                  ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat);
  }
}
