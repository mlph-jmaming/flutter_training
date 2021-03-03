import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/Transaction.dart';
import 'package:flutter_ap/layout/DashBoardLayout.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class CustomUtils {
  navigateTo(BuildContext context, Widget Function() createPage) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (buildContext) => createPage()));
  }

  navigateReplaceTo(BuildContext context, Widget Function() createPage) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (buildContext) => createPage()));
  }

  navigateToBack(BuildContext context) {
    Navigator.of(context).pop();
  }

  showToast(BuildContext context, String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  String formatCurrency(int amount) {
    final formattedNumber = new NumberFormat("#,###", "en_US");
    return "P " + formattedNumber.format(amount);
  }

  Future<void> showEnterAmountDialog(
      BuildContext context, DashBoardLayout activity) {
    int tvAmount = 0;
    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.ADD_AMOUNT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter amount to be add.'),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue))),
                    onChanged: (myAmount) {
                      tvAmount = int.parse(myAmount);
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.ADD),
              onPressed: () {
                Navigator.of(context).pop(tvAmount);
              },
            ),
          ],
        );
      },
    ).then((addedAmount) {
      if (addedAmount < 1) {
        return;
      }
      activity.updateBalance(Transaction(amount: addedAmount));
    });
  }

  Future<void> showSendMoney(BuildContext context, DashBoardLayout activity) {
    int tvAmount = 0;
    String tvAccountName = "";
    int tvAccountNumber = 0;
    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.SEND_MONEY),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Strings.ACCOUNT_NAME),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue))),
                    onChanged: (accountName) {
                      tvAccountName = accountName;
                    },
                  ),
                ),
                Text(Strings.ACCOUNT_NUMBER),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue))),
                    onChanged: (myAmount) {
                      tvAccountNumber = int.parse(myAmount);
                    },
                  ),
                ),
                Text('Please enter amount to be send.'),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue))),
                    onChanged: (myAmount) {
                      tvAmount = int.parse(myAmount);
                    },
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.SEND),
              onPressed: () {
                Navigator.of(context).pop(tvAmount);
              },
            ),
          ],
        );
      },
    ).then((sendAmount) {
      if (sendAmount < 1) {
        return;
      }
      activity.updateSendMoney(Contact(
          name: tvAccountName,
          accountNumber: tvAccountNumber,
          amount: tvAmount,
          transactionDate: DateTime.now()));
    });
  }
}
