import 'package:flutter/material.dart';

class MyNavigator {
  MyNavigator.pop({required BuildContext context}) {
    Navigator.pop(context);
  }

  MyNavigator.pushWithName(
      {required BuildContext context,
      required String routeName,
      required Map arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  MyNavigator.pushWithNameAndRemoveUntil(
      {required BuildContext context,
      required String routeName,
      required Map arguments}) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false,
        arguments: arguments);
  }
}