import 'package:flutter/material.dart';
import 'package:todo_list_app/util/todo_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[300],
      appBar: AppBar(
        title: const Text('TO DO ...'),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
        elevation: 0,
      ),
      body: ListView(
        children: [
          ToDoTile(
            taskName: 'Complete Flutter Tutorial',
            taskCompleted: false,
            onChanged: (value) {},
          ),
          ToDoTile(
            taskName: 'Buy Groceries',
            taskCompleted: true,
            onChanged: (value) {},
          ),
          ToDoTile(
            taskName: 'Walk the Dog',
            taskCompleted: false,
            onChanged: (value) {},
          ),
          ToDoTile(
            taskName: 'Read a Book',
            taskCompleted: true,
            onChanged: (value) {},
          ),
          
        ],
      ),
    );
  }
}