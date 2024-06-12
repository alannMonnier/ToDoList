import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskPreview extends StatelessWidget {

  // Créer une tache qui sera afficher par un ListTile
  final Task task;

  const TaskPreview({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        Icons.circle,
        color : (task.completed == true) ? Colors.green : Colors.red,
      ),
      selectedColor: task.completed==true ? Colors.green : Colors.red,
      title: Text(
        "Id : ${task.id}\n \nContent : ${task.content}",
      ),
      subtitle: Text(
        "Title : ${task.title}",
      ),
    );
  }
}
