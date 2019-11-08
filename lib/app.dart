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
  final _tasks = <Task>[];

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
          label: Text('Inbox'),
          icon: Icon(Icons.add),
        ),
      ),
    );
  }

  _pressedAddBtn() {
    setState(() {
      _tasks.add(Task(name: '${_tasks.length}'));
    });
    //_tasks.clear();
  }
}

class Task extends StatelessWidget {
  String name;
  TaskStatus state;
  String project;

  Task({@required this.name, this.project = 'none', this.state = TaskStatus.raw});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar (
              child: Text(name[0]),
              backgroundColor: Colors.indigoAccent,

            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(name, style: Theme.of(context).textTheme.subhead),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                child: Text('Project: $project'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}