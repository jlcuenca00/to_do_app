import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _inputController = TextEditingController();

  List tasksList = [
    ["Review Class Notes", false],
    ["Prepare for Presentation", false],
  ];

  void toggleTaskStatus(bool? value, int index) {
    setState(() {
      tasksList[index][1] = !tasksList[index][1];
    });
  }

  void addNewTask() {
    setState(() {
      tasksList.add([_inputController.text, false]);
      _inputController.clear();
    });
    Navigator.of(context).pop();
  }

  void openTaskCreator() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _inputController,
          onSave: addNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void removeTask(int index) {
    setState(() {
      tasksList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.book,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "To Do App",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        elevation: 3,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openTaskCreator,
        backgroundColor: theme.colorScheme.secondary,
        icon: const Icon(Icons.add_task, color: Colors.white),
        label: const Text(
          "Add Task",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 2,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets. symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "My Tasks",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          "${tasksList.length} items",
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.tertiary,
                        theme.colorScheme.secondary,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: tasksList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          size: 64,
                          color: Color.fromRGBO(
                            theme.colorScheme.primary.red,
                            theme.colorScheme.primary.green,
                            theme.colorScheme.primary.blue,
                            0.6,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "All caught up!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Add new tasks with the button below",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(
                              theme.colorScheme.primary.red,
                              theme.colorScheme.primary.green,
                              theme.colorScheme.primary.blue,
                              0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: tasksList.length,
                    itemBuilder: (context, index) {
                      return ToDoTile(
                        taskName: tasksList[index][0],
                        taskCompleted: tasksList[index][1],
                        onChanged: (value) => toggleTaskStatus(value, index),
                        deleteFunction: (context) => removeTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}