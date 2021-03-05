import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/custom/Strings.dart';
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

    historyList.add(HistoryTableRow().listViewItem(
        transactionDate: Strings.DATE,
        amount: Strings.AMOUNT,
        description: Strings.DESCRIPTION));
    DateFormat formatter = DateFormat('MMM dd,yyyy kk:mm');

    for (Transaction transaction
        in userInformation.getSortedTransactionHistoryDesc()) {
      historyList.add(HistoryTableRow().listViewItem(
          transactionDate: formatter.format(transaction.dateTime),
          amount: CustomUtils()
              .formatCurrency(transaction.amount, transaction.isSent),
          description: transaction.description));
    }

    // for (Contact contact in userInformation.contacts) {
    //   historyList.add(HistoryTableRow().listViewItem(
    //       transactionDate: formatter.format(contact.transactionDate),
    //       amount: "-" + CustomUtils().formatCurrency(contact.amount)));
    // }
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
}

class HistoryTableRow {
  TableRow listViewItem(
      {String transactionDate, String amount, String description}) {
    double fontSize = 15;
    double padding = 10;
    if (transactionDate != Strings.DATE) {
      fontSize = 10;
      padding = 5;
    }
    return TableRow(children: <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          amount,
          style: TextStyle(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          description,
          style: TextStyle(
            fontSize: fontSize,
          ),
          textAlign: TextAlign.center,
        ),
      ),
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
    ]);
  }
}
