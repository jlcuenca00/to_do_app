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
    required this.deleteFunction
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              foregroundColor: Colors.white,
            )
          ]
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: taskCompleted
                ? Colors.white
                : theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(12),
            border: taskCompleted
                ? Border.all(
                    color: theme.colorScheme.tertiary,
                    width: 2,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(
                  theme.colorScheme.primary.red,
                  theme.colorScheme.primary.green,
                  theme.colorScheme.primary.blue,
                  taskCompleted ? 0.1 : 0.2,
                ),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Task completion checkbox
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Checkbox(
                  value: taskCompleted, 
                  onChanged: onChanged,
                  activeColor: theme.colorScheme.secondary,
                  checkColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: BorderSide(
                    color: taskCompleted
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.tertiary,
                    width: 2,
                  ),
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Task name
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                    decoration: taskCompleted 
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    color: taskCompleted
                        ? theme.colorScheme.primary
                        : Colors.white,
                    fontWeight: taskCompleted
                        ? FontWeight.normal
                        : FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              
              // School icon indicator
              if (!taskCompleted)
                Icon(
                  Icons.school,
                  color: Colors.white.withAlpha(179), // 0.7 opacity converted to alpha value (255 * 0.7 ≈ 179)
                  size: 18,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
