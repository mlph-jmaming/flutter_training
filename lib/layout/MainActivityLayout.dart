import 'package:flutter/material.dart';
import 'package:flutter_ap/assert/Strings.dart';
import 'package:flutter_ap/class/MainActivity.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:flutter_ap/layout/AppDrawer.dart';

class MainActivityLayout {

  MaterialApp layout(Widget mainWidget, MainActivity mainActivity,
      UserInformation userInformation,String title) {
    return MaterialApp(
      title: "Flutter Training",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text(title),
        ),
        drawer: AppDrawer(mainActivity, userInformation),
        body: mainWidget,
      ),
    );
  }
}
