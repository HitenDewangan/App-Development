import 'package:flutter/material.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;

  ToDoTile({super.key, required this.taskName, this.taskCompleted = true, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
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
          color: const Color.fromARGB(255, 176, 207, 0),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}