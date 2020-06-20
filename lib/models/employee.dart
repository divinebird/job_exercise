import 'people.dart';

class Employee extends People {
  final String position;
  final int childsCount;

  Employee(id, firstname, secondname, surname, birthday, this.position, this.childsCount)
      : super(id, firstname, secondname, surname, birthday);
}
