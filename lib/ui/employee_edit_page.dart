import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/data_providers/employees_interface.dart';
import 'package:job_exercise/models/employee.dart';
import 'package:job_exercise/ui/widgets/custom_date_form_field.dart';
import 'package:job_exercise/ui/widgets/text_form_field_with_controller.dart';
import 'package:provider/provider.dart';

class EmployeeEditPage extends StatefulWidget {
  EmployeeEditPage({Key key}) : super(key: key);

  @override
  _EmployeeEditPageState createState() => _EmployeeEditPageState();
}

class _EmployeeEditPageState extends State<EmployeeEditPage> {

  final _formKey = GlobalKey<FormState>();

  TextFormFieldWithController position;
  CustomDateTimeField birthday;
  TextFormFieldWithController surname;
  TextFormFieldWithController firstname;
  TextFormFieldWithController secondname;
  FlatButton saveButton;
  
  DateTime _birthdayTime;

  _EmployeeEditPageState() : super() {
     position = TextFormFieldWithController("Должность");
     birthday = CustomDateTimeField("Дата рождения", (value) => _birthdayTime = value);
     surname = TextFormFieldWithController("Отчество");
     firstname = TextFormFieldWithController("Имя");
     secondname = TextFormFieldWithController("Фамилия");

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

class _NoOverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
