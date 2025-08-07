import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];
  var box = Hive.box('taskBox');

  void initialDefaultData() {
    todoList = [
      ["Make a todo app 1", false],
      ["Make a todo app 2", true],
      ["Make a todo app 3", false],
    ];
  }

  void loadData() {
    todoList = box.get("TODOLIST");
  }

  void updateData() {
    box.put("TODOLIST", todoList);
  }
}
