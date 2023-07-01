// this widget for custom  bottom Navigation Bar

import 'package:employee_task/controller/mixin.dart';
import 'package:flutter/material.dart';

import 'custom_btn.dart';

Widget customNavigationBar(BuildContext context, String nameEmployer) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      border: const Border(top: BorderSide(color: Colors.grey, width: 1.0)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        customBtn(
            function: () {
              Navigator.pop(context);
            },
            txt: 'Cancel',
            txtColor: Colors.blue),
        customBtn(
            function: () {
              checkBeforSubmit(context,nameEmployer);
            },
            txt: 'Save',
            color: Colors.blue)
      ],
    ),
  );
}
