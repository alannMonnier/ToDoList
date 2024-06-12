import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';

import 'master.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskMaster(taskService: TaskService()),
      title: "ToDoList",
    );
  }
}
