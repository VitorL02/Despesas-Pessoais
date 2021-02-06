import 'package:flutter/foundation.dart';

//Atributos da classe
class Transaction {
  final String id;
  final String title;
  final DateTime date;
  final double value;

//Construtor
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.date,
      @required this.value});
}
