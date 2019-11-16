import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:circular_check_box/circular_check_box.dart';

import 'package:to_do_list/overview/theme.dart';
import 'package:to_do_list/overview/routes.dart';
import 'package:to_do_list/models/todos.dart';

class InboxScreen extends StatelessWidget {
  //final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var _todos = Provider.of<TodosModel>(context);
    

    return Container(
      child: Scaffold(
        //key: scaffoldKey,
        appBar: AppBar(
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Icon(Icons.done_all, color: Colors.white,),
              Text('Garbageideas Todolist', style: TextStyle(color: Colors.white, fontSize: 14.0),),
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: <Widget>[
              Flexible(
                child: Consumer<TodosModel>(
                  builder: (context, todos, child) => ListView.builder(
                      padding: EdgeInsets.all(8.0),
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          //direction: DismissDirection.endToStart,
                          key: todos.getKey(index),
                          onDismissed: (direction) {
                            _todos.removeByKey(todos.getKey(index));
                            Scaffold.of(context).showSnackBar(SnackBar(content: Text('Removed.'),));
                            //_showSnackBar('Removed.');
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
                                    //alignment: Alignment.centerRight,
                                    child: Text(
                                      'SWIFE TO REMOVE',
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
                              index: index, name: todos.getName(index)),
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          onTap: (int newTab) => _showSnackBar('It`s not support yet.'),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.deepPurple,
          elevation: ProtoTheme.elevationLayerOne,
          onPressed: () {
            _todos.add(Task());
          },
          label: Text('Quick Add'),
          icon: Icon(Icons.add),
        ),
        
      ),
    );
  }

  //_showSnackBar(String message) => scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  _showSnackBar(String message) => {};
}

class TaskWidget extends StatefulWidget {
  final int index;
  final String name;

  TaskWidget({this.index, this.name});

  @override
  _TaskWidgetState createState() => _TaskWidgetState(index: index, name: name);
}

class _TaskWidgetState extends State<TaskWidget> {
  final int index;
  final String name;
  TextEditingController _textController;

  _TaskWidgetState({this.index, this.name}) {
    _textController = TextEditingController(text: name);
  }

  @override
  Widget build(BuildContext context) {
    TodosModel _todos = Provider.of<TodosModel>(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: ProtoTheme.elevationLayerOne,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
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
            decoration: InputDecoration.collapsed(hintText: 'Type your task.'),
            onChanged: (text) {
              _todos.setName(index, text);
            },
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.keyboard_arrow_right),
          onPressed: () => Navigator.pushNamed(context, ScreenRoutes.organizer),
        ),
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
