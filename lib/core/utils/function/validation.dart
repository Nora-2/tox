
// ignore_for_file: unused_element

import 'package:Toxicon/Features/Authantication/checker.dart';
import 'package:Toxicon/core/constants/constants.dart';
import 'package:flutter/material.dart';

bool _validate(
          String name, String email, String password, String rePassword) =>
      Checker.checkName(name) &&
      Checker.checkEmail(email) &&
      Checker.checkPassword(password) &&
      password == rePassword;

  void _wrongCase(BuildContext context, String name, String email,
      String password, String rePassword) {
    if (!Checker.checkName(name) || name.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid name");
    } else if (!Checker.checkEmail(email) || email.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid email");
    } else if (!Checker.checkPassword(password) || password.isEmpty) {
      AppMessage.customSnackBar(context: context, content: "Invalid password");
    } else if (!(password == rePassword) || rePassword.isEmpty) {
      AppMessage.customSnackBar(
          context: context, content: "Password must match");
    }
  }
