import 'package:flutter/material.dart';
import 'package:to_do_app/util/my_button.dart';

// ignore: must_be_immutable
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: theme.colorScheme.primary,
          width: 2,
        ),
      ),
      title: Row(
        children: [
          Icon(
            Icons.assignment_add,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 10),
          Text(
            "New Task",
            style: TextStyle(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: theme.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  hintText: "Add a new task",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(
                      theme.colorScheme.primary.r.toInt(),
                      theme.colorScheme.primary.g.toInt(),
                      theme.colorScheme.primary.b.toInt(),
                      0.6,
                    ),
                  ),
                ),
                cursorColor: theme.colorScheme.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(
                  text: "Cancel",
                  onPressed: onCancel,
                  isCancel: true,
                ),
                const SizedBox(width: 10),
                MyButton(
                  text: "Save",
                  onPressed: onSave,
                  isCancel: false,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
