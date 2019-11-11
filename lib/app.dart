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

enum TaskStatus{
  raw,
  processed,
  complete,
}

class TodoListApp extends StatefulWidget {
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  final _tasks = <TaskWidget>[];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Garbage To-do list',
      theme: ProtoTheme.theme,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Garbage To-do list"),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemBuilder: (_, int index) => _tasks[index],
                itemCount: _tasks.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _pressedAddBtn,
          label: Text('Quick Add'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  _pressedAddBtn() {
    setState(() {
      _tasks.add(TaskWidget());
    });
    //_tasks.clear();
  }
}

class TaskWidget extends StatefulWidget {
  String name;
  TaskStatus state;
  String project;

  TaskWidget({this.name = '', this.project = '', this.state = TaskStatus.raw});

  @override
  _TaskWidgetState createState() => _TaskWidgetState(name, state, project);
}

class _TaskWidgetState extends State<TaskWidget> {
  String name;
  TaskStatus state;
  bool isCompleted = false;
  String project;
  TextEditingController _textController = TextEditingController();
  TextStyle _textStyle;
  
  final TextStyle _notCompletedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([]),
    color: Colors.black,
  );
  final TextStyle _completedTxtStyle = TextStyle(
    decoration: TextDecoration.combine([TextDecoration.lineThrough]),
    color: Colors.grey,
  );

  _TaskWidgetState(String name, TaskStatus state, String project) {
    this.name = name;
    this.state = state;
    this.project = project;
    _textStyle = _notCompletedTxtStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        leading: Checkbox(
          value: isCompleted,
          onChanged: (bool newValue) {
            setState(() {
              isCompleted = newValue;
              if(isCompleted) {
                _textStyle = _completedTxtStyle;
              } else {
                _textStyle = _notCompletedTxtStyle;
              }

            });
          },
        ),
        title: Container(
          child: TextField(
            style: _textStyle,
            controller: _textController,
            decoration: InputDecoration.collapsed(
              hintText: "Type your task."
            ),
          ),
        ),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}