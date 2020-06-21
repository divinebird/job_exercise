import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:job_exercise/main.dart';

class CustomDateTimeField extends DateTimeField {
  CustomDateTimeField(String label, Function(DateTime) dateSetter)
      : super(
          format: App.dateFormat,
          decoration: InputDecoration(labelText: label),
          validator: (value) {
            if (value == null) return "Пожалуйста заполните поле";
            return null;
          },
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                    context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100))
                .then((value) {
              dateSetter(value);
              return value;
            });
          },
        );
}
