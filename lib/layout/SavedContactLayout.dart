import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:intl/intl.dart';

class SavedContactLayout extends StatelessWidget {
  UserInformation userInformation;
  List<TableRow> contactList;

  SavedContactLayout(UserInformation userInformation) {
    this.userInformation = userInformation;
    contactList = new List();

    contactList.add(listViewItem(
        transactionDate: Strings.TRANSCTION_DATE,
        amount: Strings.AMOUNT,
        name: Strings.NAME));

    for (Contact transaction in userInformation.contacts) {
      DateFormat formatter = DateFormat('MMM dd,yyyy kk:mm');
      contactList.add(listViewItem(
          transactionDate: formatter.format(transaction.transactionDate),
          amount: transaction.getAmount(),
          name: transaction.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Table(
          border: TableBorder(),
          children: contactList,
        ),
      ),
    );
  }

  TableRow listViewItem({String transactionDate, String amount, String name}) {
    double fontSize = 15;
    double padding = 10;
    if (name != Strings.NAME) {
      fontSize = 10;
      padding = 5;
    }

    return TableRow(children: <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          name,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          transactionDate,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(
          amount,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      )
    ]);
  }
}
