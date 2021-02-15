import 'package:despesas_pessoais/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index), //
      );

      double totalSoma = 0.0;
      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSoma += recentTransaction[i].value;
        }
      }
      return {
        'day':
            DateFormat.E().format(weekDay)[0], //Pega a letra do dia da semana
        'value': totalSoma
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Row(
        children: groupTransactions.map((tr) {
          return ChartBar(
            label: tr['day'],
            value: tr['value'],
            percent: 0,
          );
        }).toList(),
      ),
    );
  }
}
