import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete_outline,
              backgroundColor: theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              foregroundColor: Colors.white,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: taskCompleted 
                ? Colors.grey[50] 
                : theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(10),
            border: taskCompleted
                ? Border.all(color: theme.colorScheme.tertiary, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(
                  theme.colorScheme.primary.red,
                  theme.colorScheme.primary.green,
                  theme.colorScheme.primary.blue,
                  taskCompleted ? 0.1 : 0.3,
                ),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Checkbox with custom styling
              Transform.scale(
                scale: 1.1,
                child: Checkbox(
                  value: taskCompleted,
                  onChanged: onChanged,
                  activeColor: theme.colorScheme.secondary,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  side: BorderSide(
                    color:
                        taskCompleted
                            ? theme.colorScheme.secondary
                            : theme.colorScheme.tertiary,
                    width: 2,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              // Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationThickness: 2,
                    color: taskCompleted
                        ? theme.colorScheme.primary.withOpacity(0.7)
                        : Colors.white,
                    fontWeight: taskCompleted 
                        ? FontWeight.normal 
                        : FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              // Priority indicator
              if (!taskCompleted)
                Icon(
                  Icons.book,
                  color: Colors.white.withAlpha(200),
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }
}