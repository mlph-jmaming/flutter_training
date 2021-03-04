import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/Transaction.dart';

class UserInformation {
  String firstName = "Jerico";
  String lastName = "Maming";
  String email = "jerico.maming@monstar-lab.com";
  String userName = "echo";
  String password = "echo1234";
  List<Transaction> transactionHistory = new List();
  List<Contact> contacts = new List();

  String getCurrentLoadBalance() {
    int currentBalance = 0;
    for (Transaction transaction in transactionHistory) {
      currentBalance = currentBalance + transaction.amount;
    }

    for (Contact contact in this.contacts) {
      currentBalance = currentBalance - contact.amount;
    }
    return CustomUtils().formatCurrency(currentBalance);
  }

  UserInformation() {
    addTempData();
  }

  setUserInformation(String firstName, String lastName, String email) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.email = email;
    addTempData();
  }

  List<Transaction> getSortedTransactionHistoryDesc() {
    transactionHistory.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return transactionHistory;
  }

  addTransactionHistory(Transaction transaction) {
    transactionHistory.add(transaction);
    transactionHistory.sort((a, b) => b.dateTime.compareTo(a.dateTime));
  }

  addTempData() {
    //  Temporary history data
    transactionHistory.add(Transaction(amount: 1000));
    transactionHistory.add(Transaction(amount: 2000));
    transactionHistory.add(Transaction(amount: 3000));
    transactionHistory.add(Transaction(amount: 4000));
    transactionHistory.add(Transaction(amount: 5000));
  }
}
