import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  ToDoTile({super.key, required this.taskName, this.taskCompleted = true, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Row(
          children: [
            // checkbox
            Checkbox( 
              value: taskCompleted,
              onChanged: onChanged,
              activeColor: Colors.yellow.shade800,
            ),
            // task name
            Text(taskName),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.yellow.shade600,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}