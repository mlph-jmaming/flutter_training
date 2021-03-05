import 'package:flutter/material.dart';
import 'package:flutter_ap/custom/Strings.dart';
import 'package:flutter_ap/class/RegistrationPage.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';

class RegistrationLayout {
  Scaffold registrationUi(
      BuildContext context, String title, RegistrationPage registrationPage) {
    String firstName = "";
    String lastName = "";
    String email = "";
    String userName = "";
    String password = "";

    return Scaffold(
      appBar: AppBar(
          title: Text(title, textAlign: TextAlign.center), centerTitle: true),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.0),
            height: 380,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.FIRST_NAME,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                          height: 40,
                          child: TextField(
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.blue))),
                            onChanged: (fname) {
                              firstName = fname;
                            },
                          ),
                        ))
                      ],
                    ),
                  ), //FIST NAME
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.LAST_NAME,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                          height: 40,
                          child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (lname) {
                                lastName = lname;
                              }),
                        ))
                      ],
                    ),
                  ), //LAST NAME
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child:
                              Text(Strings.EMAIL, textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                          height: 40,
                          child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (emailAdd) {
                                email = emailAdd;
                              }),
                        ))
                      ],
                    ),
                  ), //Email
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.USERNAME,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                          height: 40,
                          child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (uName) {
                                userName = uName;
                              }),
                        ))
                      ],
                    ),
                  ), //USERNAME
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.PASSWORD,
                              textAlign: TextAlign.center),
                        ),
                        Expanded(
                            child: Container(
                          height: 40,
                          child: TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (mPassword) {
                                password = mPassword;
                              }),
                        ))
                      ],
                    ),
                  ), //PASSWORD
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: FlatButton(
                        color: Colors.green,
                        onPressed: () {
                          UserInformation userInfomation = UserInformation();
                          userInfomation.firstName = firstName;
                          userInfomation.lastName = lastName;
                          userInfomation.email = email;
                          userInfomation.userName = userName;
                          userInfomation.password = password;
                          registrationPage.createAccount(
                              context, userInfomation);
                        },
                        child: Text(
                          Strings.CREATE_ACCOUNT,
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
