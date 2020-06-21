import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_exercise/data_providers/childs.dart';
import 'package:job_exercise/data_providers/employees.dart';
import 'package:job_exercise/ui/employees_list_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers:
      [
        ChangeNotifierProvider(create: (_) => EmployeesProvider()),
        ChangeNotifierProvider(create: (_) => ChildsProvider())
      ],
      child: App()));
}

class App extends StatelessWidget {
  static final dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job exercise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EmployeesListPage(),
    );
  }
}


