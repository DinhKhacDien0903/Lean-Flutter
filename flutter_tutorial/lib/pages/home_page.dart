import 'package:flutter/material.dart';
import 'package:flutter_tutorial/utils/dialog_box.dart';
import 'package:flutter_tutorial/utils/todoTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List todoList = [
    ["Make a todo app 1", false],
    ["Make a todo app 2", true],
    ["Make a todo app 3", false],
    ["Make a todo app 4", true],
    ["Make a todo app 5", false],
    ["Make a todo app 6", true],
  ];

  void checkBoxChanged(bool? value, int? index) {
    setState(() {
      todoList[index!][1] = !todoList[index][1];
    });
  }

  TextEditingController textController = TextEditingController();

  void onSave() {
    setState(() {
      todoList.add([textController.text, false]);
      textController.clear();
      Navigator.of(context).pop();
    });
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
          );
        },
      ),
    );
  }
}
