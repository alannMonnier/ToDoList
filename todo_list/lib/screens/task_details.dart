import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_form.dart';

import '../models/task.dart';

class TaskDetails extends StatefulWidget {

  final Task task;


  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _DetailsState();
}

class _DetailsState extends State<TaskDetails> {


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Details Tâche"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: TaskForm(formMode : FormMode.Edit, task : widget.task),
          ),
        ),
      );
  }
}