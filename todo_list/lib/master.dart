import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';
import '../services/task_service.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  get onPressed => null;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            children: [
              TaskMaster(taskService: TaskService()),
            ]
        ),
      ),

      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
      ),
    );
  }
}
