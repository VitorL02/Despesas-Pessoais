import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)
      onSubmit; //função que vai conversar com o componente pai(transactionUser)

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 00;
//Validação de Dados ,return joga novamente pra linha 5
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  final _valueController = TextEditingController();

  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: _valueController,
              //Teclado numerico, o numberwithOptions serve pro IOS
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //Chama indiretamente a função,quando confirmar no teclado numerico transação sera adicionada
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Container(
              height: 60,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        _selectedDate == null
                            ? 'Nenhuma data selecionada'
                            : 'Data Selecionada ${DateFormat('EE dd/MM/y').format(_selectedDate)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway')),
                  ),
                  FlatButton(
                    textColor: Colors.purple[400],
                    child: Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                    color: Colors.deepPurple[800],
                    onPressed: _submitForm,
                    textColor: Colors.white,
                    child: Text('Nova Transação',
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
