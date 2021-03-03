import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/CustomSize.dart';
import 'package:flutter_ap/class/LoginPage.dart';
import 'package:flutter_ap/assert/Strings.dart';

class LoginLayout {
  Scaffold LogInUi(String title, LogInPage logInPage) {
    return Scaffold(
      appBar: AppBar(
          title: Text(title, textAlign: TextAlign.center), centerTitle: true),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Container(
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0),
                  width: 500,
                  height: 250,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            width: 100,
                            alignment: AlignmentDirectional.topStart,
                            child: Text(Strings.USERNAME,
                                style: TextStyle(
                                    fontSize: CustomSize.TEXT_SIZE,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Container(
                            alignment: AlignmentDirectional.topStart,
                            width: 160,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (myUserName) {
                                logInPage.setUserName(myUserName);
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 15.0, top: 20.0),
                            width: 100,
                            alignment: AlignmentDirectional.topStart,
                            child: Text(Strings.PASSWORD,
                                style: TextStyle(
                                    fontSize: CustomSize.TEXT_SIZE,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            alignment: AlignmentDirectional.topStart,
                            width: 160,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.blue))),
                              onChanged: (myPassword) {
                                logInPage.setPassword(myPassword);
                              },
                              obscureText: true,
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: 35.0,
                        width: 150,
                        margin: EdgeInsets.only(
                          top: 15.0,
                        ),
                        alignment: AlignmentDirectional.center,
                        child: FlatButton(
                          color: Colors.green,
                          onPressed: () {
                            logInPage.loginOnPress();
                          },
                          minWidth: 200.0,
                          height: 60.0,
                          child: Text(
                            Strings.LOGIN,
                            style: TextStyle(
                                fontSize: CustomSize.TEXT_SIZE,
                                color: Colors.white),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                        ),
                      ),
                      Container(
                        height: 50,
                        alignment: AlignmentDirectional.center,
                        child: TextButton(
                          onPressed: () {
                            logInPage.registerOnPress();
                          },
                          child: Text(
                            Strings.REGISTER,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
