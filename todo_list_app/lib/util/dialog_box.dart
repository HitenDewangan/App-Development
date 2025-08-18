import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;

  DialogBox({
    super.key, 
    required this.controller,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Task'),
      content: TextField(
        controller: controller,
        autofocus: true,
        onSubmitted: (value) {
          onSave(); // this already handles adding + closing
        },
        decoration: const InputDecoration(
          hintText: 'Enter task name',
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.clear();
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onSave,
          child: const Text('Add Task'),
        ),
      ],
    );
  }
}
