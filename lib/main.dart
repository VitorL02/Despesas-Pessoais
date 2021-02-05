import 'package:flutter/material.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Despesas Pessoais',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          backgroundColor: Colors.deepPurple[800]),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              child: Text('Grafico'),
              elevation: 5,
            ),
          ),
          Card(
            child: Text(
              'Lista de transações',
            ),
            elevation: 5,
          )
        ],
      ),
    );
  }
}
