import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:to_do_list/overview/theme.dart';
import 'package:to_do_list/overview/routes.dart';
import 'package:to_do_list/models/todos.dart';

enum TaskEditingState {
  nothingEditing,
  thisIsEditing,
  anotherTaskIsEdting,
}

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  bool isSomethingTaskEditing;

  @override
  Widget build(BuildContext context) {
    var _todos = Provider.of<TodosModel>(context);

    final _appBar = AppBar(
      elevation: 0.0,
      title: Row(
        children: <Widget>[
          Icon(
            Icons.done_all,
            color: Colors.white,
          ),
          Text(
            'Garbageideas Todolist',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );

    final _body = GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Column(
        children: <Widget>[
          Flexible(
            child: Consumer<TodosModel>(
              builder: (context, todos, child) {
                return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: todos.getKey(index),
                        onDismissed: (direction) {
                          _todos.removeByKey(todos.getKey(index));
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('Removed.'),
                          ));
                        },
                        background: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Container(
                            alignment: Alignment.center,
                            color: ProtoTheme.red,
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Center(
                                  child: Text(
                                    'SWIPE TO REMOVE',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        child: TaskWidget(
                            index: index,
                            name: todos.getName(index),
                            isSomethingTaskEditing: false),
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );

    final _bottomNavigationBar = BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.inbox),
          title: Text('Inbox'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_view_day),
          title: Text('Timeline'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check),
          title: Text('Project'),
        ),
      ],
      currentIndex: 0,
      backgroundColor: ProtoTheme.purple,
      unselectedItemColor: Colors.white,
      selectedItemColor: ProtoTheme.yellow,
      onTap: (int newTab) => {},
    );

    final _floatingActionButton = FloatingActionButton.extended(
      backgroundColor: Colors.deepPurple,
      elevation: ProtoTheme.elevationLayerOne,
      onPressed: () {
        _todos.add(Task());
      },
      label: Text('Quick Add'),
      icon: Icon(Icons.add),
    );

    return Scaffold(
      appBar: _appBar,
      body: _body,
      bottomNavigationBar: _bottomNavigationBar,
      floatingActionButton: _floatingActionButton,
    );
  }
}

class TaskWidget extends StatefulWidget {
  final int index;
  final String name;
  final bool isSomethingTaskEditing;

  TaskWidget({this.index, this.name, this.isSomethingTaskEditing});

  @override
  _TaskWidgetState createState() => _TaskWidgetState(
      index: index, name: name, isSomethingTaskEditing: isSomethingTaskEditing);
}

class _TaskWidgetState extends State<TaskWidget> {
  final int index;
  final String name;
  final bool isSomethingTaskEditing;
  bool isThisEditing;
  TextEditingController _textController;
  bool get isBlocked => isSomethingTaskEditing && !isThisEditing;

  _TaskWidgetState({this.index, this.name, this.isSomethingTaskEditing}) {
    _textController = TextEditingController(text: name);
    isThisEditing = false;
  }

  @override
  Widget build(BuildContext context) {
    TodosModel _todos = Provider.of<TodosModel>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: isThisEditing
          ? ProtoTheme.elevationLayerThree
          : ProtoTheme.elevationLayerOne,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircularCheckBox(
              value: _todos.getChecked(index),
              onChanged: (bool newValue) {
                _todos.setChecked(index, newValue);
              },
            ),
            title: Container(
              child: TextField(
                style: _todos.getChecked(index)
                    ? _checkedTxtStyle
                    : _notCheckedTxtStyle,
                autocorrect: false,
                controller: _textController,
                decoration: InputDecoration(border: InputBorder.none),
                onChanged: (text) {
                  _todos.setName(index, text);
                },
              ),
            ),
            trailing: IconButton(
              icon: Icon(isThisEditing
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right),
              onPressed: () => setState(() =>
                  isThisEditing ? isThisEditing = false : isThisEditing = true),
            ),
          ),
          isThisEditing
              ? SizedBox(
                  height: 50,
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
    );
  }

  static final TextStyle _notCheckedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([]),
    color: Colors.black,
    fontSize: 18.0,
  );
  static final TextStyle _checkedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([TextDecoration.lineThrough]),
    color: Colors.grey,
    fontSize: 18.0,
  );
}
