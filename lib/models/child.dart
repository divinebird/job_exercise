import 'people.dart';

class Child extends People {
  final String parentId;

  Child(id, firstname, secondname, surname, birthday, this.parentId)
      : super(id, firstname, secondname, surname, birthday);
}
