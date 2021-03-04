import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/CustomSize.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/Transaction.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DashBoardLayout extends StatelessWidget {
  UserInformation userInformation;
  BuildContext myBuidContext;
  List<TableRow> historyList;

  DashBoardLayout(UserInformation userInformation) {
    this.userInformation = userInformation;
  }

  updateBalance(Transaction transaction) {
    userInformation.addTransactionHistory(transaction);
    (myBuidContext as Element).markNeedsBuild();
  }

  updateSendMoney(Contact contact) {
    userInformation.contacts.add(contact);
    (myBuidContext as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    myBuidContext = context;
    historyList = new List();

    historyList.add(listViewItem(
        transactionDate: Strings.TRANSCTION_DATE, amount: Strings.AMOUNT));
    DateFormat formatter = DateFormat('MMM dd,yyyy kk:mm');

    List<Transaction> histories =
        userInformation.getSortedTransactionHistoryDesc();
    for (int i = 0; i < 5; i++) {
      Transaction transaction = histories[i];
      historyList.add(listViewItem(
          transactionDate: formatter.format(transaction.dateTime),
          amount: CustomUtils().formatCurrency(transaction.amount)));
    }

    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      Strings.CURRENT_BALANCE,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
                Text(
                  userInformation.getCurrentLoadBalance().toString(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  CustomUtils().showEnterAmountDialog(context, this);
                },
                minWidth: 200.0,
                height: 60.0,
                child: Text(
                  Strings.ADD_AMOUNT,
                  style: TextStyle(
                      fontSize: CustomSize.TEXT_SIZE, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: Colors.green,
                onPressed: () {
                  CustomUtils().showSendMoney(context, this);
                },
                minWidth: 200.0,
                height: 60.0,
                child: Text(
                  Strings.SEND_MONEY,
                  style: TextStyle(
                      fontSize: CustomSize.TEXT_SIZE, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: FlatButton(
                color: Colors.green,
                onPressed: () async {
                  List<Permission> requestpermission = new List();
                  if (await Permission.camera.request().isDenied) {
                    requestpermission.add(Permission.camera);
                  }
                  if (await Permission.storage.request().isDenied) {
                    requestpermission.add(Permission.storage);
                  }
                  if (requestpermission.isNotEmpty) {
                    Map<Permission, PermissionStatus> statuses =
                        await requestpermission.request();
                    if (statuses.length == 0) {
                      String cameraScanResult = await scanner.scan();
                      List<String> qrScanResult = cameraScanResult.split(":");
                      CustomUtils().showSendMoney(context, this,
                          name: qrScanResult[2],
                          accountNumber: int.parse(qrScanResult[1]));
                    } else {
                      CustomUtils()
                          .showToast(context, Strings.PERMISSION_REQUIRED);
                    }
                  } else {
                    String cameraScanResult = await scanner.scan();
                    List<String> qrScanResult = cameraScanResult.split(":");
                    CustomUtils().showSendMoney(context, this,
                        name: qrScanResult[2],
                        accountNumber: int.parse(qrScanResult[1]));
                  }
                },
                minWidth: 200.0,
                height: 60.0,
                child: Text(
                  Strings.SCAN_QR_CODE,
                  style: TextStyle(
                      fontSize: CustomSize.TEXT_SIZE, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0)),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Table(
                border: TableBorder(),
                children: historyList,
              ),
            )
          ],
        ),
      ),
    ));
  }

  TableRow listViewItem({String transactionDate, String amount}) {
    double fontSize = 20;
    double padding = 10;
    if (transactionDate != Strings.TRANSCTION_DATE) {
      fontSize = 15;
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
