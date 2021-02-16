import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percent;

  ChartBar({
    this.label,
    this.value,
    this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(children: <Widget>[
          Container(
            height: constrains.maxHeight * 0.15,
            child: FittedBox(
              // Diminiue o texto pra 'caber no grafico',caso o valor seja muito alto
              child: Text('\$${value.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
            height: constrains.maxHeight * 0.6,
            width: 10,
            child: Stack(alignment: Alignment.bottomCenter, children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepPurple[800],
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ]),
          ),
          SizedBox(height: constrains.maxHeight * 0.05),
          Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(child: Text(label))),
        ]);
      },
    );
  }
}
//constrains.maxHeight Pega o valor do tamanho especifico que envolve o componente (resposividade)
