import 'package:flutter_ap/class/CustomUtils.dart';

class Contact {
  String name;
  String description;
  int amount;
  DateTime transactionDate;

  Contact({this.name, this.amount, this.description, this.transactionDate});

  String getAmount() {
    return CustomUtils().formatCurrency(amount, false);
  }
}
