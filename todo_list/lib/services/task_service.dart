import 'package:faker/faker.dart';

import 'package:todo_list/models/task.dart';

class TaskService {

  late List<Task> tasks;

  // Retourne une Future de type 'List' (liste d'objets Task)
  Future<List<Task>>? fetchTask() async {
    var faker = new Faker();
    var tab = ["low", "normal", "high"];
    tasks = List.generate(100,
            (index) => Task(
            pTitle: faker.lorem.sentence(),
            content: faker.lorem.sentence(),
            userid: uuid.v1(),
            dueDate: faker.date.dateTime(),
            priority: tab[faker.randomGenerator.integer(tab.length)],
            completed: faker.randomGenerator.boolean()
        ));
    return tasks;
  }


  // Méthode qui permet d'ajouter une tâche à la liste des tâches
  void createTask(Task task) {
    tasks.insert(0, task);
  }
}
