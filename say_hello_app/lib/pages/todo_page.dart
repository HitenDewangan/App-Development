import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {

  // text editing controller
  TextEditingController myController = TextEditingController();

  // greeting message variable
  String greetMessage = "";
  // greet user method
  void greetUser() {
    String username = myController.text.trim();
    setState(() {
      greetMessage = "Hello, $username!";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(23.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // greeting text message
              Text(greetMessage,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              // text input field
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                  hintText: 'e.g., John Doe',
                ),
              ),
        
              // button
              ElevatedButton(
                onPressed: () {
                  // action when button is pressed
                  greetUser(); // call the greet user method
                  // show a snackbar with the greeting message
                  if (greetMessage.isNotEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User greeted: $greetMessage')),
                    );
                    myController.clear(); // clear the input field
                  }
                },
                child: Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}