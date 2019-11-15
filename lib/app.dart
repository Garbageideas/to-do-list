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
import 'package:to_do_list/screens/inbox_screen.dart';
import 'package:to_do_list/screens/test_screen.dart';


// import 'package:cloud_firestore/cloud_firestore.dart';

class TodoListApp extends StatefulWidget {
  @override
  _TodoListAppState createState() => _TodoListAppState();
}

class _TodoListAppState extends State<TodoListApp> {
  @override
  Widget build(BuildContext context) {

    // Firestore.instance.collection("task").document("temp2").setData({"memo" :"junsik"});

    return MaterialApp(
      title: 'Garbage To-do list',
      theme: ProtoTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => InboxScreen(),
        '/second': (context) => TestViewApp(),
      },
    );
  }
}