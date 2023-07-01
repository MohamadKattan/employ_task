// this widget custom floating btn

import 'package:flutter/material.dart';

Widget customFloatinBtn({required Function navToPage}) {
  return GestureDetector(
    onTap: () {
      navToPage();
    },
    child: Container(
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(8.0)),
      width: 50,
      height: 50,
      child: const Icon(
        Icons.add,
        size: 35,
        color: Colors.white,
      ),
    ),
  );
}
