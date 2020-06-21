
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/employees_interface.dart';
import 'package:job_exercise/models/employee.dart';

class SimpleEmployeesProvider extends EmployeesProvider {

  final _employeesList = <Employee>[];

  get count  => Future.value(_employeesList.length);

  Future<Employee> getEmployee(int index) => Future.value(_employeesList[index]);

  addEmployee(Employee newItem) {
    _employeesList.add(newItem);
    notifyListeners();
  }
}