import 'package:flutter/material.dart';
import 'package:task_managment/task_list_add_screen.dart';
import 'package:task_managment/task_list_screen.dart';

class taskManagment extends StatelessWidget {
  const taskManagment({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task_Managmnet",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:ColorScheme.fromSeed(
          seedColor:const Color(0xff00aff),
     ),

      ),
        home: const TaskListScreen(),
    );

  }
}
