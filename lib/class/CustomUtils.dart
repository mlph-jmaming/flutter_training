import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/custom/Strings.dart';
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

  String formatCurrency(int amount, bool isNegative) {
    final formattedNumber = new NumberFormat("#,###", "en_US");
    String convertedValue;
    if (isNegative) {
      convertedValue = "-P ";
    } else {
      convertedValue = "P ";
    }
    return convertedValue + formattedNumber.format(amount);
  }

  Future<void> showEnterAmountDialog(
      BuildContext context, DashBoardLayout activity) {
    int tvAmount = 0;
    String tvDescription = "";
    return showDialog<Transaction>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.ADD_AMOUNT),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Strings.PLEASE_ENTER_DESCRIPTION),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.blue))),
                    onChanged: (myDescription) {
                      tvDescription = myDescription;
                    },
                  ),
                ),
                Text(Strings.PLEASE_ENTER_AMOUNT),
                Container(
                  margin: EdgeInsets.only(top: 10),
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
                Navigator.of(context).pop(
                    Transaction(amount: tvAmount, description: tvDescription));
              },
            ),
          ],
        );
      },
    ).then((addedAmount) {
      if (addedAmount.amount < 1) {
        return;
      }
      activity.updateBalance(addedAmount);
    });
  }

  Future<void> showSendMoney(BuildContext context, DashBoardLayout activity,
      {String name, String description}) {
    int tvAmount = 0;
    String tvAccountName;
    String tvDescription;
    bool saveAsNewContact = false;
    List<String> dropDownItem = new List();
    dropDownItem.add(Strings.NEW_USER);

    // debugPrint('echo:' + name + " des:" + description);
    for (Contact contact in activity.userInformation.contacts) {
      dropDownItem.add(contact.name);
    }

    String selectedDropdownitem = dropDownItem.first;
    bool isCheckBoxVisible = true;

    if (activity.userInformation.contacts.length > 0 &&
        name != null &&
        dropDownItem.contains(name)) {
      Contact contact =
          activity.userInformation.contacts[dropDownItem.indexOf(name) - 1];
      tvAccountName = contact.name;
      tvDescription = contact.description;
      selectedDropdownitem = contact.name;
      isCheckBoxVisible = false;
    }
    if (tvAccountName == null && name != null) {
      tvAccountName = name;
      if (dropDownItem.contains(name)) {
        selectedDropdownitem = name;
      }
    } else if (tvAccountName == null) {
      tvAccountName = "";
    }

    if (tvDescription == null && description != null) {
      tvDescription = description;
    } else if (tvDescription == null) {
      tvDescription = "";
    }

    return showDialog<int>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(Strings.SEND_MONEY),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Text(
                          Strings.SEND_TO,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: DropdownButton<String>(
                          value: selectedDropdownitem,
                          items: dropDownItem.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child:
                                  new Text(value, textAlign: TextAlign.center),
                            );
                          }).toList(),
                          onChanged: (selectedItem) {
                            Contact selectedContact;
                            if (selectedItem == Strings.NEW_USER) {
                              selectedContact =
                                  Contact(name: "", description: "", amount: 0);
                            } else {
                              selectedContact =
                                  activity.userInformation.contacts[
                                      dropDownItem.indexOf(selectedItem) - 1];
                            }

                            if (selectedItem == Strings.NEW_USER) {
                              isCheckBoxVisible = true;
                            } else {
                              isCheckBoxVisible = false;
                            }
                            setState(() {
                              selectedDropdownitem = selectedItem;
                              tvAccountName = selectedContact.name;
                              tvDescription = selectedContact.description;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  Visibility(
                      visible: isCheckBoxVisible,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(
                            Strings.SAVE_AS_NEW_CONTACT,
                            style: TextStyle(fontSize: 12),
                            textAlign: TextAlign.start,
                          ),
                          value: saveAsNewContact,
                          onChanged: (newValue) {
                            setState(() {
                              saveAsNewContact = newValue;
                            });
                          },
                        ),
                      )),
                  Text(Strings.NAME),
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 20),
                    child: TextField(
                      controller: TextEditingController(text: tvAccountName),
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
                  Text(Strings.DESCRIPTION),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: TextField(
                      controller:
                          TextEditingController(text: tvDescription.toString()),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.blue))),
                      onChanged: (myDescription) {
                        tvDescription = myDescription;
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
        });
      },
    ).then((sendAmount) {
      if (sendAmount < 1) {
        return;
      }
      activity.updateSendMoney(
          Contact(
              name: tvAccountName,
              description: tvDescription,
              amount: tvAmount,
              transactionDate: DateTime.now()),
          saveAsNewContact);
    });
  }
}
