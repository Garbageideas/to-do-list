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
  final _tasks = <TaskWidget>[];
  var serialNumber = 0;

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
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                itemCount: _todos.items.length,
                itemBuilder: (context, index) {
                  final thisItem = _todos.items[index];

                  return Dismissible(
                    key: thisItem.key,
                    onDismissed: (direction) {
                      _todos.remove(index);
                      Scaffold
                        .of(context)
                        .showSnackBar(SnackBar(content: Text("SWIPE TO REMOVE"),));
                    },
                    background: Container(
                      color: Colors.red,
                      child: Container(
                        child: Center(child: Text('SWIPE TO REMOVE', style: TextStyle(color: Colors.white),),),
                      ),
                    ),
                    child: TaskWidget(),
                  );
                }
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _todos.add(Task()),
          label: Text('Quick Add'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  _pressedAddBtn() {
    setState(() {
      final keyString = '${DateTime.now()}';
      _tasks.add(TaskWidget(key:Key(keyString)));
    });
  }
}

class TaskWidget extends StatefulWidget {
  Key key;
  String name;
  TaskStatus state;
  String project;

  TaskWidget({this.key, this.name = '', this.project = '', this.state = TaskStatus.rawTask});

  @override
  _TaskWidgetState createState() => _TaskWidgetState(name, state, project);
}

class _TaskWidgetState extends State<TaskWidget> {
  String name;
  TaskStatus state;
  bool isCompleted = false;
  String project;
  TextEditingController _textController;
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
    var _todos = Provider.of<TodosModel>(context);

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
            autocorrect: false,
            controller: _textController,
            decoration: InputDecoration.collapsed(
              hintText: 'Type your task.'
            ),
            onChanged: (text) {
              // TODO:: todos model 속 텍스트를 변경해야 하는데 index값을 알 수 없어서 검토 필요. key 값 기반으로 찾아야 할 듯.
            },
          ),
        ),
        trailing: Icon(
          Icons.more_vert
        ),
      ),
    );
  }
}