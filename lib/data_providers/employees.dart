
import 'package:flutter/widgets.dart';
import 'package:job_exercise/models/employee.dart';

class EmployeesProvider extends ChangeNotifier {

  final _employeesList = <Employee>[];

  get count  => _employeesList.length;

  Employee getEmployee([int index]) => _employeesList[index];

  addEmployee(Employee newItem) {
    _employeesList.add(newItem);
    notifyListeners();
  }
}