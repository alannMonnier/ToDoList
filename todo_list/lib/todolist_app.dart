import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';

class TodoListApp extends StatelessWidget {
  const TodoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskMaster(),
      title: "ToDoList",
      routes : {
        '/taskForm': (context) => const TaskForm(),
      }
    );
  }
}



