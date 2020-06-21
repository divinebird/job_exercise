
import 'package:flutter/widgets.dart';
import 'package:job_exercise/models/child.dart';

class ChildsProvider extends ChangeNotifier {
  final _childsList = Map<int,List<Child>>();

  int getCountForParent(int id) {
    return _childsList[id]?.length ?? 0;
  }

  Child getChildForParent(int index, int parentId) {
    return _childsList[parentId]?.elementAt(index);
  }

  addChild(int parentId, Child newChild) {
    var childsForParent = _childsList[parentId];
    if(childsForParent == null) {
      childsForParent = List<Child>();
      _childsList[parentId] = childsForParent;
    }
    childsForParent.add(newChild);
    notifyListeners();
  }

}