import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exercise/data_providers/childs.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/main.dart';
import 'package:job_exercise/ui/childs_list_page.dart';
import 'package:job_exercise/ui/employee_edit_page.dart';
import 'package:provider/provider.dart';

class EmployeesListPage extends StatefulWidget {
  EmployeesListPage({Key key}) : super(key: key);

  @override
  _EmployeesListPageState createState() => _EmployeesListPageState();
}

class _EmployeesListPageState extends State<EmployeesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Сотрудники'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(5),
          itemBuilder: _itemBuilder,
          itemCount: context.watch<EmployeesProvider>().count),
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
    final childsCount = context.watch<ChildsProvider>().getCountForParent(curEmployee.id);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (pushContext) {
            return ChildsListPage(curEmployee.id);
          }),
        );
      },
      child: Card(
        child: Container(
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
              Text('Детей: $childsCount'),
            ],
          ),
        ),
      ),
    );
  }
}
