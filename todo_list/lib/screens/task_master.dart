import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/task_details.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/services/task_service.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../widgets/task_preview.dart';
import '../services/task_service.dart';

var uuid = const Uuid();

final TaskService taskService = TaskService();

class TaskMaster extends StatefulWidget {


  const TaskMaster({super.key});

  @override
  _TaskMaster createState() => _TaskMaster();
}



class _TaskMaster extends State<TaskMaster>{


  // Initialise les tâches au chargement de la page
  @override
  void initState() {
    super.initState();
    // Récupère les tâches depuis le taskService
    _fetchTasks();
  }

  // Récupère les taches et les ajoute a la liste du TaskProvider
  Future<void> _fetchTasks() async {
    List<Task>? tasks = await TaskService().fetchTask();
    // Récupère l'instance de TaskProvider depuis le context du widget
    context.read<TaskProvider>().createListTasks(tasks!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // Consumer va écouter les changements du provider pour modifier la liste des tâches
          child: Consumer<TaskProvider>(
              // context du widget courant, instance de TaskProvider
              builder: (context, taskProvider, child){
                  return Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: taskProvider.getList().length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                  onTap: () async {
                                    // On récupère le résultat pour savoir si oui ou non on met à jour la liste de tache
                                    final tacheModifiee = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder : (context) => TaskDetails(task : taskProvider.getList()[index]),
                                      ),
                                    );

                                    final bool modif = tacheModifiee['modif'];
                                    if(modif == true){

                                      // Modification de la tache sélectionnée
                                      taskProvider.updatedTask(tacheModifiee["task"].getId(), tacheModifiee["task"]);
                                    }
                                  },
                                  child: TaskPreview(task: taskProvider.getList()[index]),
                              );
                              // Obliger de mettre un point ! pour imposer que la valeur en paramètre n'est pas nulle

                            },
                          ),
                        ),
                    ]
                  );
                }
          ),
        ),
    );
  }
}
