import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
  }) : super(key: key);

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${widget.tr.value}'),
            ),
          ),
        ),
        title: Text(widget.tr.title,
            style:
                TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.bold)),
        subtitle: Text(DateFormat('EEE d MMM y').format(widget.tr.date)),
        trailing: MediaQuery.of(context).size.width > 480
            ? FlatButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                icon: Icon(Icons.delete),
                label: Text('Excluir'),
                textColor: Colors.redAccent,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
    );
  }
}
