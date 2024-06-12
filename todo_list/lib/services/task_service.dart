import 'package:faker/faker.dart';

import 'package:todo_list/models/task.dart';

class TaskService {


  // Retourne une Future de type 'List' (liste d'objets Task)
  Future<List<Task>>? fetchTask() async {
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
}
