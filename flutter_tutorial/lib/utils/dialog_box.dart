import 'package:flutter/material.dart';
import 'package:flutter_tutorial/utils/my_button.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Create new task!"),
      backgroundColor: Colors.yellow,
      content: Container(
        height: 360,
        width: 300,
        child: Column(
          spacing: 30,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task",
              ),
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  displayText: "Save",
                  onPressed: onSave,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                ),

                MyButton(
                  displayText: "Cancel",
                  onPressed: onCancel,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
