
import 'package:job_exercise/data_providers/database.dart';
import 'package:job_exercise/data_providers/employees_interface.dart';
import 'package:job_exercise/models/employee.dart';

class DbEmployeesProvider extends EmployeesProvider {
  @override
  Future<void> addEmployee(Employee newItem) {
    return DatabaseProvider().addEmployee(newItem).then((value) {
      notifyListeners();
      return Future.value();
    });
  }

  final _tmpList = List<Employee>();

  @override
  Future<int> get count {
    _tmpList.clear();
    return DatabaseProvider().employeesCount;
  }

  @override
  Future<Employee> getEmployee(int index) {
    if(_tmpList.isNotEmpty)
      return Future.value(_tmpList[index]);

    return DatabaseProvider().getEmployees().then((list) {
      _tmpList.addAll(list);
      return Future.value(_tmpList[index]);
    });
  }

}