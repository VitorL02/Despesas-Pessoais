import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //SingleChildScrollView = Widget que torna  a tela scrollavel// ListView e um componente pra lista (parecido com o SingleChildScrollView )
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Nenhuma Transação Cadastrada!',
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/Images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              //Desempenho da aplicação,define quantos itens serão renderizados (trabalha como o .map)
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final tr = transactions[index];
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.deepPurple[600],
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'R\$ ${tr.value.toStringAsFixed(2)}', //Interpolação de Strings,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple[600],
                          ),
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(tr.title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            Text(DateFormat('EEE d/MMM/y ').format(tr.date),
                                style: TextStyle(
                                  color: Colors.grey,
                                )),
                          ]),
                    ],
                  ),
                );
              }),
    );
  }
}
