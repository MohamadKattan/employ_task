import 'package:flutter/material.dart';

Widget customTextFailed(
    {required TextEditingController? controller,
    String? lable,
    String? hintText,
    TextInputType? inputType,
    Color? fillColor,
    Color? labelColor,
    double? margin,
    Widget? prefixIcon}) {
  return Container(
    margin: EdgeInsets.all(margin ?? 0.0),
    child: TextField(
      controller: controller,
      keyboardType: inputType,
      enabled: true,
      decoration: InputDecoration(
        prefixIcon: prefixIcon ?? const Icon(Icons.person_outline,color: Colors.blue,),
        contentPadding: const EdgeInsets.all(15.0),
        filled: true,
        fillColor: fillColor ?? Colors.transparent,
        labelText: lable ?? 'Employee Name',
        labelStyle: TextStyle(color: labelColor ?? Colors.black),
        hintText: hintText ?? '',
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
      ),
    ),
  );
}
