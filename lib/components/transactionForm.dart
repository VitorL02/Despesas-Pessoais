import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 00;
//Validação de Dados ,return joga novamente pra linha 5
    if (title.isEmpty || value <= 0) {
      return;
    }
    onSubmit(title, value);
  }

  final valueController = TextEditingController();
  final titleController = TextEditingController();

  final void Function(String, double)
      onSubmit; //função que vai conversar com o componente pai(transactionUser)

  TransactionForm(this.onSubmit);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Titulo',
              ),
            ),
            TextField(
              controller: valueController,
              //Teclado numerico, o numberwithOptions serve pro IOS
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              //Chama indiretamente a função,quando confirmar no teclado numerico transação sera adicionada
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                    onPressed: _submitForm,
                    textColor: Colors.purple,
                    child: Text('Nova Transação')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
