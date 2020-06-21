import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/childs.dart';
import 'package:job_exercise/data_providers/childs_interface.dart';
import 'package:job_exercise/models/child.dart';
import 'package:job_exercise/ui/widgets/custom_date_form_field.dart';
import 'package:job_exercise/ui/widgets/text_form_field_with_controller.dart';
import 'package:provider/provider.dart';

class ChildEditPage extends StatefulWidget {
  final String _parentId;

  ChildEditPage(this._parentId, {Key key}) : super(key: key);

  @override
  _ChildEditPageState createState() => _ChildEditPageState();
}

class _ChildEditPageState extends State<ChildEditPage> {
  final _formKey = GlobalKey<FormState>();

  CustomDateTimeField birthday;
  TextFormFieldWithController surname;
  TextFormFieldWithController firstname;
  TextFormFieldWithController secondname;
  FlatButton saveButton;

  DateTime _birthdayTime;

  _ChildEditPageState() : super() {
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
        title: Text('Ребенок'),
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
          children: <Widget>[secondname, firstname, surname, birthday, saveButton],
        ),
      ),
    );
  }

  void _save() {
    if (_formKey.currentState.validate()) {
      context.read<ChildsProvider>().addChild(
          Child(null, firstname.controller.text, secondname.controller.text, surname.controller.text, _birthdayTime, widget._parentId));
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
