import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:job_exercise/data_providers/childs.dart';
import 'package:job_exercise/data_providers/childs_interface.dart';
import 'package:job_exercise/main.dart';
import 'package:job_exercise/models/child.dart';
import 'package:job_exercise/ui/child_edit_page.dart';
import 'package:provider/provider.dart';

class ChildsListPage extends StatefulWidget {
  final String _parentId;

  ChildsListPage(this._parentId, {Key key}) : super(key: key);

  @override
  _ChildsListPageState createState() => _ChildsListPageState();
}

class _ChildsListPageState extends State<ChildsListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Дети'),
      ),
      body: FutureBuilder<int>(
          future: context.watch<ChildsProvider>().getCountForParent(widget._parentId),
          builder: (context, snapshot) => snapshot.hasData
              ? ListView.builder(padding: EdgeInsets.all(5), itemBuilder: _itemBuilder, itemCount: snapshot.data)
              : Container()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (pushContext) {
              return ChildEditPage(widget._parentId);
            }),
          );
        },
        tooltip: 'add employee',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return FutureBuilder<Child>(
      future: context.watch<ChildsProvider>().getChildForParent(index, widget._parentId),
      builder: (context, snapshot) => snapshot.hasData
          ? Card(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Фамилия: ${snapshot.data.secondname}'),
                    SizedBox(height: 3),
                    Text('Имя: ${snapshot.data.firstname}'),
                    SizedBox(height: 3),
                    Text('Отчество: ${snapshot.data.surname}'),
                    SizedBox(height: 3),
                    Text('Дата рождения: ${App.dateFormat.format(snapshot.data.birthday)}'),
                  ],
                ),
              ),
            )
          : Container(),
    );
  }
}
