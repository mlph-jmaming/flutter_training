import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/MainActivity.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:flutter_ap/layout/LoginLayout.dart';
import 'CustomUtils.dart';
import 'RegistrationPage.dart';

class LogInPage extends StatefulWidget {
  LogInPage({this.title, this.userInformation});

  final String title;
  _LogInPageState logInPageState;
  UserInformation userInformation;

  @override
  _LogInPageState createState() {
    logInPageState = _LogInPageState(this,userInformation);
    if (userInformation != null) {
      logInPageState.userInformation = userInformation;
    } else {
      logInPageState.userInformation = UserInformation();
    }

    return logInPageState;
  }

  setUserName(String username) {
    logInPageState.userName = username;
  }

  setPassword(String password) {
    logInPageState.password = password;
  }

  loginOnPress() {
    logInPageState.login();
  }

  registerOnPress() {
    logInPageState.registerAccount(userInformation);
  }
}

class _LogInPageState extends State<LogInPage> {
  String userName;
  String password;
  LogInPage logInPage;
  UserInformation userInformation;

  _LogInPageState(LogInPage logInPage, UserInformation) {
    this.logInPage = logInPage;
    this.userInformation = userInformation;
  }

  @override
  Widget build(BuildContext context) {
    return LoginLayout().LogInUi(widget.title, logInPage);
  }

  registerAccount(UserInformation userInformation) {
    CustomUtils().navigateTo(
        context,
            () =>
            RegistrationPage(userInformation, (userResult) {
              this.userInformation = userResult;
            }));
  }

  login() {
    if ((userName != null && userName.isNotEmpty) &&
        (password != null && password.isNotEmpty) &&
        (userInformation.userName == userName &&
            userInformation.password == password)) {
      CustomUtils()
          .navigateReplaceTo(context, () => MainActivity(userInformation));
    } else {
      String message;
      if (userName == null || userName.isEmpty) {
        message = Strings.USER_NAME_EMTPY;
      } else if (password == null || password.isEmpty) {
        message = Strings.PASSWORD_EMTPY;
      } else {
        message = Strings.LOGIN_FAILED;
      }
      CustomUtils().showToast(context, message);
    }
  }
}
