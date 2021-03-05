import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ap/custom/Strings.dart';
import 'package:flutter_ap/class/CustomUtils.dart';
import 'package:flutter_ap/dataObject/UserInformation.dart';
import 'package:flutter_ap/layout/RegistrationLayout.dart';

class RegistrationPage extends StatefulWidget {
  UserInformation userInformation;
  Function(UserInformation) callBack;

  RegistrationPage(this.userInformation, this.callBack);

  _RegistrationPageState _registrationPageState;

  @override
  State<StatefulWidget> createState() {
    _registrationPageState = _RegistrationPageState(this);
    _registrationPageState.userInformation = userInformation;
    return _registrationPageState;
  }

  createAccount(BuildContext context, UserInformation userInformation) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(userInformation.email);
    if (!emailValid) {
      CustomUtils().showToast(context, Strings.WRONG_EMAIL);
      return;
    }
    bool passwordValidation = iPasswordValid(userInformation.password);
    if (!passwordValidation) {
      CustomUtils().showToast(context, Strings.PASSWORD_INVALID);
      return;
    }

    this.userInformation = userInformation;
    callBack(this.userInformation);
    _registrationPageState.gotoBack();
  }

  bool iPasswordValid(String password, [int minLength = 5]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasMinLength = password.length > minLength;
    return hasDigits & (hasUppercase || hasLowercase) & hasMinLength;
  }
}

class _RegistrationPageState extends State<RegistrationPage> {
  UserInformation userInformation;
  RegistrationPage registrationPage;

  _RegistrationPageState(RegistrationPage registrationPage) {
    this.registrationPage = registrationPage;
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationLayout()
        .registrationUi(context, Strings.REGISTRATION, registrationPage);
  }

  void gotoBack() {
    CustomUtils().navigateToBack(context);
  }
}
