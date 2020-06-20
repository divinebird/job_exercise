import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/main.dart';
import 'package:job_exercise/ui/employee_edit_page.dart';
import 'package:provider/provider.dart';

class EmployeeListPage extends StatefulWidget {
  EmployeeListPage({Key key}) : super(key: key);

  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      body: ListView.separated(
          padding: EdgeInsets.all(5),
          itemBuilder: _itemBuilder,
          itemCount: context.watch<EmployeesProvider>().count,
          separatorBuilder: (innerContext, index) => Divider(color: Colors.grey)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (pushContext) {
              return EmployeeEditPage();
            }),
          );
        },
        tooltip: 'add employee',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    final curEmployee = context.watch<EmployeesProvider>().getEmployee(index);
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Фамилия: ${curEmployee.secondname}'),
          SizedBox(height: 3),
          Text('Имя: ${curEmployee.firstname}'),
          SizedBox(height: 3),
          Text('Отчество: ${curEmployee.surname}'),
          SizedBox(height: 3),
          Text('Дата рождения: ${App.dateFormat.format(curEmployee.birthday)}'),
          SizedBox(height: 3),
          Text('Должность: ${curEmployee.position}'),
          SizedBox(height: 3),
          Text('Детей: ${curEmployee.childsCount}'),
        ],
      ),
    );
  }
}
