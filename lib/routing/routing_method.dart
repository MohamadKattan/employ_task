import 'package:flutter/material.dart';

// this method for navigatore by pushed name
void navigatorByNameRouting(
    {required BuildContext context,
    required String routeName,
    Object? argument}) {
  Navigator.pushNamed(context, routeName, arguments: argument);
}
