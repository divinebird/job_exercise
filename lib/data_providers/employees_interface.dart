
import 'package:flutter/widgets.dart';
import 'package:job_exercise/models/employee.dart';

abstract class EmployeesProvider extends ChangeNotifier {
  Future<int> get count;
  Future<Employee> getEmployee(int index);
  Future<void> addEmployee(Employee newItem);
}