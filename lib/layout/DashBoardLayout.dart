import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/CustomSize.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/dataObject/Contact.dart';
import 'package:flutter_ap/dataObject/Transaction.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';

class DashBoardLayout extends StatelessWidget {
  UserInformation userInformation;
  BuildContext myBuidContext;

  DashBoardLayout(UserInformation userInformation) {
    this.userInformation = userInformation;
  }

  updateBalance(Transaction transaction){
    userInformation.transactionHistory.add(transaction);
    (myBuidContext as Element).markNeedsBuild();
  }

  updateSendMoney(Contact contact){
    userInformation.contacts.add(contact);
    (myBuidContext as Element).markNeedsBuild();
  }

  @override
  Widget build(BuildContext context) {
    myBuidContext = context;
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ),
                    Text(
                      userInformation.getCurrentLoadBalance().toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
              ],
            ),
          ),
        ));
  }
}

