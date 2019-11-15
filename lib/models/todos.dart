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
  final List<Task> _tasks = []; /* local database. */

  int get length {
    return _tasks.length;
  }

  void add(Task task) {
    task.key = Key('${DateTime.now()}');
    _tasks.add(task);
    notifyListeners();
  }

  void remove(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void removeByKey(Key keyToFind) {
    _tasks.removeWhere((item) => (item.key == keyToFind));
    notifyListeners();
  }

  bool getChecked(int index) => _tasks[index].state==TaskStatus.completed;

  setChecked(int index, bool newValue) {
    if(newValue == true) {
      _tasks[index].state = TaskStatus.completed;
    } else {
      if(_tasks[index]._hasProcessedCondition()) {
        _tasks[index].state = TaskStatus.processed;
      } else {
        _tasks[index].state = TaskStatus.rawTask;
      }
    }
    notifyListeners();
  }

  setName(int index, String newValue) {
    _tasks[index].name = newValue;
  }

  String getName(int index) {
    return _tasks[index].name;
  }

  Key getKey(int index) {
    return _tasks[index].key;
  }
}