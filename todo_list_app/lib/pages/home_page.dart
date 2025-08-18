import 'package:flutter/material.dart';
import 'package:todo_list_app/util/dialog_box.dart';
import 'package:todo_list_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // controller for text field
  final _controller = TextEditingController();


  // list of todo tasks
  List toDoList = [
    ['Make Tutorial', true],
    ['Do Exercise', false],
    ['Buy Milk', false],
    ['Read Book', true],
    ['Walk the Dog', false],
    ['Clean the House', false],
    ['Plan Vacation', true],
  ];

  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  // create new task
  void createNewTask() {
    showDialog(
      context: context, 
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
        );
      }
    );
  }

  // save new task
  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigo[200],
      ),
      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
          );
        },
      ),
    );
  }
}