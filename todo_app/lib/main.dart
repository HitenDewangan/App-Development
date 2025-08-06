import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  // static List<String> names = [
  //   'Alice', 'Bob', 'Charlie', 'David', 'Eve',
  //   'Frank', 'Grace', 'Heidi', 'Ivan', 'Judy',
  // ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold( // Using Scaffold to provide a basic material design layout
        backgroundColor: const Color.fromARGB(255, 79, 5, 163),
        
        body: Stack(
          children: [
            Center(
              child: Text(
                'Hello, World!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ])
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}