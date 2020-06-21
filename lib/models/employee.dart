import 'people.dart';

class Employee extends People {
  final String position;

  Employee(id, firstname, secondname, surname, birthday, this.position)
      : super(id, firstname, secondname, surname, birthday);
}
