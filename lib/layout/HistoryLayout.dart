import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/Transaction.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:intl/intl.dart';

class HistoryLayout extends StatelessWidget {
  UserInformation userInformation;
  List<TableRow> historyList;

  HistoryLayout(UserInformation userInformation) {
    this.userInformation = userInformation;
    historyList = new List();

    historyList.add(listViewItem(
        transactionDate: Strings.TRANSCTION_DATE, amount: Strings.AMOUNT));
    DateFormat formatter = DateFormat('MMM dd,yyyy kk:mm');

    for (Transaction transaction
        in userInformation.getSortedTransactionHistoryDesc()) {
      historyList.add(listViewItem(
          transactionDate: formatter.format(transaction.dateTime),
          amount: CustomUtils().formatCurrency(transaction.amount)));
    }

    for (Contact contact in userInformation.contacts) {
      historyList.add(listViewItem(
          transactionDate: formatter.format(contact.transactionDate),
          amount: "-" + CustomUtils().formatCurrency(contact.amount)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Table(
          border: TableBorder(),
          children: historyList,
        ),
      ),
    );
  }

  TableRow listViewItem({String transactionDate, String amount}) {
    double fontSize = 15;
    double padding = 10;
    if (transactionDate != Strings.TRANSCTION_DATE) {
      fontSize = 10;
      padding = 5;
    }

    return TableRow(children: <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          transactionDate,
          style: TextStyle(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          amount,
          style: TextStyle(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }
}
