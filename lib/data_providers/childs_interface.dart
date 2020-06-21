
import 'package:flutter/widgets.dart';
import 'package:job_exercise/models/child.dart';

abstract class ChildsProvider extends ChangeNotifier {
  Future<int> getCountForParent(String id);
  Future<Child> getChildForParent(int index, String parentId);
  Future<void> addChild(Child newChild);
}