import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:job_exercise/data_providers/childs.dart';
import 'package:job_exercise/data_providers/childs_interface.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/data_providers/employees_interface.dart';
import 'package:job_exercise/main.dart';
import 'package:job_exercise/models/employee.dart';
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
      body: FutureBuilder<int>(
          future: context.watch<EmployeesProvider>().count,
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(padding: EdgeInsets.all(5), itemBuilder: _itemBuilder, itemCount: snapshot.data)
              : Container()),
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
    return FutureBuilder<Employee>(
        future: context.watch<EmployeesProvider>().getEmployee(index),
        builder: (context, snapshot) => snapshot.hasData
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (pushContext) {
                      return ChildsListPage(snapshot.data.id);
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
                        Text('Фамилия: ${snapshot.data.secondname}'),
                        SizedBox(height: 3),
                        Text('Имя: ${snapshot.data.firstname}'),
                        SizedBox(height: 3),
                        Text('Отчество: ${snapshot.data.surname}'),
                        SizedBox(height: 3),
                        Text('Дата рождения: ${App.dateFormat.format(snapshot.data.birthday)}'),
                        SizedBox(height: 3),
                        Text('Должность: ${snapshot.data.position}'),
                        SizedBox(height: 3),
                        FutureBuilder<int>(future: context.watch<ChildsProvider>().getCountForParent(snapshot.data.id),
                          initialData: 0,
                          builder: (context, snapshot) => Text('Детей: ${snapshot.data}'),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Container());
  }
}
