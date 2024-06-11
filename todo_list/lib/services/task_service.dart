import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:todo_list/models/task.dart';
import 'package:todo_list/screens/task_preview.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class TaskService extends StatefulWidget {
  const TaskService({super.key});

  @override
  State<TaskService> createState() => _TaskService();
}

class _TaskService extends State<TaskService> {

  // Retourne une Future de type 'List' (liste d'objets Task)
  Future<List<Task>>? _fetchTask() async {
    var faker = new Faker();
    List<Task> tasks = List.generate(100,
        (index) => Task(
          pTitle: faker.lorem.sentence(),
          content: faker.lorem.sentence(),
          userid: uuid.v1(),
          dueDate: faker.date.dateTime(),
          priority: "low",
          completed: faker.randomGenerator.boolean()
        ));
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: FutureBuilder<List<Task>>(
          future: _fetchTask(),
          // Builder gérer le cas d'error, de data et de load
          builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot){

              if(snapshot.hasData){
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index){
                    // Obliger de mettre un point ! pour imposer que la valeur en paramètre n'est pas nulle
                    return TaskPreview(task: snapshot.data![index]);
                  },
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
    );
  }
}
