import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import './TransactionItem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
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
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/Images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            //Desempenho da aplicação,define quantos itens serão renderizados (trabalha como o .map)
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                // Utilizado para definir uma key unica,em um listview.BUILDER
                key: GlobalObjectKey(tr),
                tr: tr,
                onRemove: onRemove,
              );
            });
  }
}
