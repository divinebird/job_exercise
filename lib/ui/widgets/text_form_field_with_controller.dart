
import 'package:flutter/material.dart';

class TextFormFieldWithController extends TextFormField {
  TextFormFieldWithController(String label)
      : super(
      decoration: InputDecoration(labelText: label),
      controller: TextEditingController(),
      validator: (value) {
        if (value.isEmpty) return "Пожалуйста заполните поле";
        return null;
      });
}