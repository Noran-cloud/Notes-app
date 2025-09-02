import 'package:flutter/material.dart';
import 'package:rwad2/Screens/add_note.dart';
import 'package:rwad2/Screens/notes.dart';
import 'package:rwad2/Screens/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: Notes_Screen(),
    );
  }
}
