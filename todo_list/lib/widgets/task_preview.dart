import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';

import '../models/task.dart';

class TaskPreview extends StatefulWidget {

  // Créer une tache qui sera afficher par un ListTile
  final Task task;

  // Booléen si la tâche est complète ou non

  const TaskPreview({super.key, required this.task});

  @override
  _TaskPreview createState() => _TaskPreview();
}

class _TaskPreview extends State<TaskPreview>{

  // Retourne la couleur pour le bouton de priorité
  MaterialColor _getColorPriority(){
    if(widget.task.priority == "low"){
      return Colors.yellow;
    }else{
      return (widget.task.priority == "normal") ? Colors.orange : Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          leading: Icon(
            Icons.circle,
            color : _getColorPriority(),
          ),
          title: Text(
            "Id : ${widget.task.id} \nContent : ${widget.task.content}",
          ),
          trailing: Column(
            children: [
              Expanded(
                child: Checkbox(
                  value: widget.task.completed,
                  onChanged: (bool? value) {
                    setState((){
                      widget.task.completed = value!;
                    });
                  },
                ),
              ),

              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Provider.of<TaskProvider>(context, listen: false).removeTaskById(widget.task.id);
                },
              ),

            ],
          ),
        ),
    );
  }
}
