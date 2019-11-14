// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
import 'package:to_do_list/src/theme.dart';
import 'package:to_do_list/models/todos.dart';
import 'package:provider/provider.dart';

class TodoListApp extends StatefulWidget {
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {

  @override
  Widget build(BuildContext context) {
    var _todos = Provider.of<TodosModel>(context);

    return MaterialApp(
      title: 'Garbage To-do list',
      theme: ProtoTheme.theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Garbage To-do list"),
        ),
        body: Column(
          children: <Widget>[
            Consumer<TodosModel>(

              builder: (context, todos, child) => Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  itemCount: todos.length,
                  itemBuilder: (context, index) {

                    return Dismissible(
                      key: todos.getKey(index),
                      onDismissed: (direction) {
                        _todos.removeByKey(todos.getKey(index));
                          Scaffold
                            .of(context)
                            .showSnackBar(SnackBar(content: Text("SWIPE TO REMOVE"),));
                      },
                      background: Container(
                        color: ProtoTheme.red,
                        child: Container(
                          child: Center(child: Text('SWIPE TO REMOVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
                        ),
                      ),
                      child: TaskWidget(index: index, name: todos.getName(index)),
                    );
                  }
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _todos.add(Task());

          },
          label: Text('Quick Add'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }
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
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        leading: Checkbox(
          value: _todos.getChecked(index),
          onChanged: (bool newValue) {
            _todos.setChecked(index, newValue);

          },
        ),
        title: Container(
          child: TextField(
            style: _todos.getChecked(index) ? _checkedTxtStyle : _notCheckedTxtStyle,
            autocorrect: false,
            controller: _textController,
            decoration: InputDecoration.collapsed(
              hintText: 'Type your task.'
            ),
            onChanged: (text) {
              _todos.setName(index, text);
            },
          ),
        ),
        trailing: Icon(
          Icons.more_vert
        ),
      ),
    );
  }

  static final TextStyle _notCheckedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([]),
    color: Colors.black,
  );
  static final TextStyle _checkedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([TextDecoration.lineThrough]),
    color: Colors.grey,
  );
}