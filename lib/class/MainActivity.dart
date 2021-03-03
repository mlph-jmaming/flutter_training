import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/class/LoginPage.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:flutter_ap/layout/DashBoardLayout.dart';
import 'package:flutter_ap/layout/MainActivityLayout.dart';

class MainActivity extends StatefulWidget {
  _MainActivity mainState;
  UserInformation userInformation;

  MainActivity(UserInformation userInformation) {
    this.userInformation = userInformation;
  }

  @override
  State<StatefulWidget> createState() {
    mainState = _MainActivity(this, userInformation);
    return mainState;
  }

  switchDrawer(Widget route, String title) {
    mainState.switchLayout(route, title);
  }

  logoutUser() {
    CustomUtils().navigateReplaceTo(
        mainState.context,
        () => LogInPage(
              title: 'Login Page',
              userInformation: userInformation,
            ));
  }
}

class _MainActivity extends State<MainActivity> {
  Widget mainWidget;
  MainActivity mainActivity;
  UserInformation userInformation;
  String title = Strings.DASHBOARD;

  _MainActivity(MainActivity mainActivity, UserInformation userInformation) {
    this.mainActivity = mainActivity;
    this.userInformation = userInformation;
    mainWidget = DashBoardLayout(userInformation);
  }

  switchLayout(Widget routes, String title) {
    setState(() {
      mainWidget = routes;
      this.title = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainActivityLayout()
        .layout(mainWidget, mainActivity, userInformation, title);
  }
}
