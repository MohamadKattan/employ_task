// this widget for custom btn

import 'package:flutter/material.dart';

Widget customBtn(
    {Color? color,
    Color? txtColor,
    required Function function,
    required String txt}) {
  return GestureDetector(
    onTap: () {
      function();
    },
    child: Container(
      width: 80.0,
      height: 40.0,
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
          color: color ?? Colors.blue.shade100,
          borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: Text(
          txt,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              color: txtColor ?? Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}
