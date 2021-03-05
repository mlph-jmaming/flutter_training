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
  int sentMoney = 0;

  String getCurrentLoadBalance() {
    int currentBalance = 0;
    for (Transaction transaction in transactionHistory) {
      if (!transaction.isSent)
        currentBalance = currentBalance + transaction.amount;
    }

    // for (Contact contact in this.contacts) {
    //   currentBalance = currentBalance - contact.amount;
    // }
    currentBalance = (currentBalance - sentMoney);
    return CustomUtils().formatCurrency(currentBalance, false);
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
    transactionHistory.add(Transaction(amount: 1000, description: "Deposit 1"));
    transactionHistory.add(Transaction(amount: 2000, description: "Deposit 2"));
    transactionHistory.add(Transaction(amount: 3000, description: "Deposit 3"));
    transactionHistory.add(Transaction(amount: 4000, description: "Deposit 4"));
    transactionHistory.add(Transaction(amount: 5000, description: "Deposit 5"));
  }
}
