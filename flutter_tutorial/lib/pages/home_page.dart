import 'package:flutter/material.dart';
import 'package:flutter_tutorial/data/database.dart';
import 'package:flutter_tutorial/utils/dialog_box.dart';
import 'package:flutter_tutorial/utils/todoTile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box('taskBox');
  TodoDatabase db = TodoDatabase();
  List todoList = [];

  @override
  void initState() {
    if (box.get("TODOLIST") == null) {
      db.initialDefaultData();
      db.updateData();
    } else {
      db.loadData();
    }
    todoList = db.todoList;
    super.initState();
  }

  void checkBoxChanged(bool? value, int? index) {
    setState(() {
      todoList[index!][1] = !todoList[index][1];
    });
    db.updateData();
  }

  TextEditingController textController = TextEditingController();

  void onSave() {
    setState(() {
      todoList.add([textController.text, false]);
      textController.clear();
      Navigator.of(context).pop();
    });
    db.updateData();
  }

  void onCancel() {
    textController.clear();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: textController,
        onSave: onSave,
        onCancel: onCancel,
      ),
    );
  }

  void deleteTask(BuildContext contex, int index) {
    {
      if (todoList[index][1]) {
        setState(() {
          todoList.removeAt(index);
        });
        db.updateData();
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Cannot delete completed task"),
            content: Text("Please check the task before deleting."),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => createNewTask(),
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoList[index][0],
            taskCompleted: todoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(context, index),
          );
        },
      ),
    );
  }
}
