import 'package:flutter/material.dart';
import 'package:todo_app/pages/second_page.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('1st Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/secondpage');
          }, 
          child: Text('Go to 2nd Page'),
      ),
    ),
    );
  }
}