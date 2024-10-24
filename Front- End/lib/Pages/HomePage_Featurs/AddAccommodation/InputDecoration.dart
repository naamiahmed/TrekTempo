import 'package:flutter/material.dart';

final OutlineInputBorder borderStyle = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.blue, width: 2.0),
  borderRadius: BorderRadius.circular(8.0),
);

InputDecoration getInputDecoration(String labelText) {
  return InputDecoration(
    labelText: labelText,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    border: borderStyle,
    enabledBorder: borderStyle,
    focusedBorder: borderStyle,
  );
}