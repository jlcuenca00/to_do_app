import 'package:flutter/material.dart';
import 'package:to_do_app/util/dialog_box.dart';
import 'package:to_do_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  List toDoList = [
    ["Complete Assignment", false],
    ["Study for Exams", false],
  ];

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(40),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ClipOval(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.school,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Asian College Tasks",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: theme.colorScheme.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            color: theme.colorScheme.primary,
            child: const Row(
              children: [
                Text(
                  "1972",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
                Text(
                  "Student Task Manager",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: toDoList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 70,
                          color: Color.fromRGBO(
            theme.colorScheme.primary.r.toInt(),
            theme.colorScheme.primary.g.toInt(),
            theme.colorScheme.primary.b.toInt(),
            0.7,
          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "No tasks yet",
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Add tasks using the + button",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(
                              theme.colorScheme.primary.r.toInt(),
                              theme.colorScheme.primary.g.toInt(),
                              theme.colorScheme.primary.b.toInt(),
                              0.7,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: toDoList.length,
                    itemBuilder: (context, index) {
                      return ToDoTile(
                        taskName: toDoList[index][0],
                        taskCompleted: toDoList[index][1],
                        onChanged: (value) => checkBoxChanged(value, index),
                        deleteFunction: (context) => deleteTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
