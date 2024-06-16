import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_details.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder<List<Task>>(
              future: taskService.fetchTask(),
              // Builder gérer le cas d'error, de data et de load
              builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: snapshot.data?.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                  onTap: () async {
                                    // On récupère le résultat pour savoir si oui ou non on met à jour la liste de tache
                                    final tacheAjoutee = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder : (context) => TaskDetails(task : snapshot.data![index]),
                                      ),
                                    );

                                    // Si on a effectué une modification et validé alors on met a jour la liste
                                    if(tacheAjoutee != null){
                                      setState(() {
                                        snapshot.data![index] = tacheAjoutee;
                                      });
                                    }

                                  },
                                  child: TaskPreview(task: snapshot.data![index]),
                              );
                              // Obliger de mettre un point ! pour imposer que la valeur en paramètre n'est pas nulle

                            },
                          ),
                        ),
                    ]
                  );
                }
                else if(snapshot.hasError){
                  return Text('Error : ${snapshot.error}');
                }
                // Chargement
                else{
                  return const Text("Loading...");
                }
              }
          ),
        ),
    );
  }
}
