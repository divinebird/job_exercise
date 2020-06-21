import 'package:job_exercise/models/child.dart';
import 'package:job_exercise/models/employee.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  Future<Database> db;
  static final DatabaseProvider _instance = DatabaseProvider._();

  static final String _employeesTable = "employee";
  static final String _childsTable = "childs";

  static final String _idColumn = "id";
  static final String _firstnameColumn = "firstname";
  static final String _secondnameColumn = "secondname";
  static final String _surnameColumn = "surname";
  static final String _birthdayColumn = "birthday";
  static final String _positionColumn = "position";
  static final String _parentIdColumn = "parent_id";

  DatabaseProvider._() {
    db = openDatabase(
      'database.db',
      version: 1,
      onCreate: (db, version) {
        db.execute('''
create table $_employeesTable (
  $_idColumn varchar(80) primary key,
  $_firstnameColumn text,
  $_secondnameColumn text,
  $_surnameColumn text,
  $_birthdayColumn timestamp,
  $_positionColumn text
)
''');
        db.execute('''
create table $_childsTable (
  $_idColumn varchar(80) primary key,
  $_firstnameColumn text,
  $_secondnameColumn text,
  $_surnameColumn text,
  $_birthdayColumn timestamp,
  $_parentIdColumn varchar(80)
)
''');
      },
    );
  }

  factory DatabaseProvider() {
    return _instance;
  }

  Future<int> get employeesCount =>
      db.then((db) => db.rawQuery("select count(*) from $_employeesTable")).then((value) => Sqflite.firstIntValue(value));

  Future<int> childCountForParent(String id) {
    return db
        .then((db) => db.rawQuery("select count(*) from $_childsTable where $_parentIdColumn = ?", [id]))
        .then((value) => Sqflite.firstIntValue(value));
  }

  Future<void> addEmployee(Employee employee) {
    return db.then((db) => db.rawInsert('''
insert into $_employeesTable($_idColumn, $_firstnameColumn, $_secondnameColumn, $_surnameColumn, $_birthdayColumn, $_positionColumn)
values("${employee.id}", "${employee.firstname}", "${employee.secondname}",
 "${employee.surname}", ${employee.birthday.millisecondsSinceEpoch / 1000}, "${employee.position}")
'''));
  }

  Future<void> addChild(Child child) {
    return db.then((db) => db.rawInsert('''
insert into $_childsTable($_idColumn, $_firstnameColumn, $_secondnameColumn, $_surnameColumn, $_birthdayColumn, $_parentIdColumn)
values("${child.id}", "${child.firstname}", "${child.secondname}",
 "${child.surname}", ${child.birthday.millisecondsSinceEpoch / 1000}, "${child.parentId}")
'''));
  }

  Future<List<Employee>> getEmployees() {
    return db.then((db) => db.rawQuery('select * from $_employeesTable').then((items) => items
        .map((item) => Employee(item[_idColumn], item[_firstnameColumn], item[_secondnameColumn], item[_surnameColumn],
            DateTime.fromMillisecondsSinceEpoch(item[_birthdayColumn] * 1000), item[_positionColumn]))
        .toList(growable: false)));
  }

  Future<List<Child>> getChilds(String parantId) {
    return db.then((db) => db.rawQuery('select * from $_childsTable where $_parentIdColumn = ?', [parantId]).then((items) => items
        .map((item) => Child(item[_idColumn], item[_firstnameColumn], item[_secondnameColumn], item[_surnameColumn],
            DateTime.fromMillisecondsSinceEpoch(item[_birthdayColumn] * 1000), parantId))
        .toList(growable: false)));
  }
}
