// this widget for custom appBar

import 'package:flutter/material.dart';

PreferredSizeWidget custoAppBar(String? title) {
  return AppBar(
    automaticallyImplyLeading: false,
    title: Text(title ?? ''),
    centerTitle: false,
  );
}
