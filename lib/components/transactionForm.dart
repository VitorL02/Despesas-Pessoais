import 'package:despesas_pessoais/components/adaptativeDataPicker.dart';
import 'package:flutter/material.dart';

import 'adaptativeButton.dart';
import 'adaptativeTextField.dart';
import 'adaptativeDataPicker.dart';

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

  final _valueController = TextEditingController();

  final _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                controller: _titleController,
                onSubmitted: (_) => _submitForm(),
                labelText: 'Titulo',
              ),
              AdaptativeTextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                labelText: 'Valor (R\$)',
              ),
              AdaptativeDataPicker(
                selectedDate: _selectedDate,
                onDateChange: (newDate) {
                  setState(() {
                    _selectedDate = newDate;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
