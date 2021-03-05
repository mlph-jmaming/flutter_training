import 'package:flutter/material.dart';
import 'package:flutter_ap/custom/Strings.dart';
import 'package:flutter_ap/class/MainActivity.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:flutter_ap/layout/DashBoardLayout.dart';
import 'package:flutter_ap/layout/HistoryLayout.dart';
import 'package:flutter_ap/layout/SavedContactLayout.dart';

class AppDrawer extends StatelessWidget {
  MainActivity mainActivity;
  UserInformation userInformation;

  AppDrawer(MainActivity mainActivity, UserInformation userInformation) {
    this.mainActivity = mainActivity;
    this.userInformation = userInformation;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: Strings.DASHBOARD,
              onTap: () => {
                    mainActivity.switchDrawer(
                        DashBoardLayout(userInformation), Strings.DASHBOARD),
                    Navigator.of(context).pop()
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.history,
              text: Strings.TRANSACTION_HISTORY,
              onTap: () => {
                    mainActivity.switchDrawer(HistoryLayout(userInformation),
                        Strings.TRANSACTION_HISTORY),
                    Navigator.of(context).pop()
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.contact_phone_outlined,
              text: Strings.SAVE_CONTACT_LIST,
              onTap: () => {
                    mainActivity.switchDrawer(
                        SavedContactLayout(userInformation),
                        Strings.SAVE_CONTACT_LIST),
                    Navigator.of(context).pop()
                  }),
          Divider(),
          _createDrawerItem(
              icon: Icons.logout,
              text: Strings.LOGOUT,
              onTap: () =>
                  {mainActivity.logoutUser(), Navigator.of(context).pop()}),
          Divider(),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('path/to/header_background.png'))),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 12.0,
            left: 16.0,
            child: Text("Flutter Step-by-Step",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500))),
      ]));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
