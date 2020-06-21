import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/main.dart';
import 'package:job_exercise/models/employee.dart';
import 'package:provider/provider.dart';

class EmployeeEditPage extends StatefulWidget {
  EmployeeEditPage({Key key}) : super(key: key);

  @override
  _EmployeeEditPageState createState() => _EmployeeEditPageState();
}

class _EmployeeEditPageState extends State<EmployeeEditPage> {

  final _formKey = GlobalKey<FormState>();

  _EmployeeTextFormField position;
  DateTimeField birthday;
  _EmployeeTextFormField surname;
  _EmployeeTextFormField firstname;
  _EmployeeTextFormField secondname;
  FlatButton saveButton;
  
  DateTime _birthdayTime;

  _EmployeeEditPageState() : super() {
     position = _EmployeeTextFormField("Должность");
     birthday = DateTimeField(
      format: App.dateFormat,
      decoration: InputDecoration(labelText: "Дата рождения"),
      validator: (value) {
        if (value == null) return "Пожалуйста заполните поле";
        return null;
      },
      onShowPicker: (context, currentValue) {
        return showDatePicker(
            context: context, firstDate: DateTime(1900), initialDate: currentValue ?? DateTime.now(), lastDate: DateTime(2100)).then((value) => _birthdayTime = value);
      },
    );
     surname = _EmployeeTextFormField("Отчество");
     firstname = _EmployeeTextFormField("Имя");
     secondname = _EmployeeTextFormField("Фамилия");

    saveButton = FlatButton(
      onPressed: _save,
      child: Text("Сохринать"),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Сотрудник'),
      ),
      body: _getBody(context));

  Widget _getBody(BuildContext context) {
    return ScrollConfiguration(
      behavior: _NoOverScrollBehavior(),
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints.tight(
            Size(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height),
          ),
          child: _getForm(context),
        ),
      ),
    );
  }

  Widget _getForm(BuildContext context) {

    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[secondname, firstname, surname, birthday, position, saveButton],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      context.read<EmployeesProvider>().addEmployee(Employee(null, firstname.controller.text, secondname.controller.text,
          surname.controller.text, _birthdayTime, position.controller.text));
      Navigator.pop(context);
    }
  }
}

class _EmployeeTextFormField extends TextFormField {
  _EmployeeTextFormField(String label)
      : super(
            decoration: InputDecoration(labelText: label),
            controller: TextEditingController(),
            validator: (value) {
              if (value.isEmpty) return "Пожалуйста заполните поле";
              return null;
            });
}

class _NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
