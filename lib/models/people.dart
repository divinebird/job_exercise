
import 'package:uuid/uuid.dart';

class People {
  final String id;
  final String firstname;
  final String secondname;
  final String surname;
  final DateTime birthday;

  People(id, this.firstname, this.secondname, this.surname, this.birthday) : this.id = id ?? Uuid().v1();
}