
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/childs_interface.dart';
import 'package:job_exercise/models/child.dart';

class SimpleChildsProvider extends ChildsProvider {
  final _childsList = Map<String,List<Child>>();

  Future<int> getCountForParent(String id) => Future.value(_childsList[id]?.length ?? 0);

  Future<Child> getChildForParent(int index, String parentId) => Future.value(_childsList[parentId]?.elementAt(index));

  Future<void> addChild(Child newChild) {
    var childsForParent = _childsList[newChild.parentId];
    if(childsForParent == null) {
      childsForParent = List<Child>();
      _childsList[newChild.parentId] = childsForParent;
    }
    childsForParent.add(newChild);
    notifyListeners();
    return Future.value();
  }

}