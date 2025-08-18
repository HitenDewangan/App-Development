import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;

  ToDoTile({super.key, 
  required this.taskName, 
  required this.taskCompleted, 
  required this.onChanged,
  required this.deleteTask
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: deleteTask,
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              borderRadius: BorderRadius.circular(10),
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Row(
            children: [
              // checkbox
              Checkbox( 
                value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.blueGrey[600],
              ),
              // task name
              Text(
                taskName,
                style: TextStyle(
                  fontSize: 17.0,
                  color: Colors.black87,
                  decoration: taskCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 129, 179, 72),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}