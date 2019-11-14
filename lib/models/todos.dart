import 'package:flutter/material.dart';
import 'package:to_do_list/preference/preference_task.dart';

/*

Provider pattern
example: https://flutter-ko.dev/docs/development/data-and-backend/state-mgmt/simple

*/

enum TaskStatus {
  rawTask,
  processed,
  completed,
}

class Task {
  Key key;
  String name;
  String project;
  TaskStatus state;  
  String context;
  bool get isCompleted => (state==TaskStatus.completed);
  set isCompleted(bool b) {
    if(b == true) {
      state = TaskStatus.completed;
    } else {
      if(_hasProcessedCondition()) {
        state = TaskStatus.processed;
      } else {
        state = TaskStatus.rawTask;
      }
    }
  }

  Task({this.key, this.name, this.project = '', this.state = TaskStatus.rawTask, this.context = ''});

  bool _hasProcessedCondition() {
    switch(PreferenceOfTask.taskProcessedCondition)
    {
      case TaskProcessedCondition.hasProject:
        return (project.length != 0);
        break;
      case TaskProcessedCondition.hasContext:
        return (context.length != 0);
        break;
      case TaskProcessedCondition.hasBothOfProjectAndContext:
        return ((project.length != 0)&&(context.length != 0));
        break;
      default:
        return (context.length != 0);
        break;
    }
  }

}

class TodosModel extends ChangeNotifier {
  final List<Task> _tasks = [];

  List<Task> get items => _tasks;

  void add(Task task) {
    task.key = Key('${DateTime.now()}');
    _tasks.add(task);
    notifyListeners();
  }

  void remove(int index) {
    _tasks.removeAt(index);
  }
}