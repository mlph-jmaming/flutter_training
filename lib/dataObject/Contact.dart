import 'package:flutter_ap/class/CustomUtils.dart';

class Contact {
  String name;
  int accountNumber;
  int amount;
  DateTime transactionDate;

  Contact({this.name, this.amount, this.accountNumber, this.transactionDate});

  String getAmount(){
    return CustomUtils().formatCurrency(amount);
  }
}
