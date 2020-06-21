
import 'package:job_exercise/data_providers/childs_interface.dart';
import 'package:job_exercise/data_providers/database.dart';
import 'package:job_exercise/models/child.dart';

class DbChildsProvider extends ChildsProvider {
  @override
  Future<void> addChild(Child newChild) {
    return DatabaseProvider().addChild(newChild).then((value) {
      notifyListeners();
      return Future.value();
    });
  }

  final _tmpList = List<Child>();

  @override
  Future<int> getCountForParent(String id) {
    _tmpList.clear();
    return DatabaseProvider().childCountForParent(id);
  }

  @override
  Future<Child> getChildForParent(int index, String parentId) {
    if(_tmpList.isNotEmpty)
      if(_tmpList.first?.parentId == parentId)
        return Future.value(_tmpList[index]);
      else
        _tmpList.clear();

    return DatabaseProvider().getChilds(parentId).then((list) {
      _tmpList.addAll(list);
      return Future.value(_tmpList[index]);
    });
  }

}