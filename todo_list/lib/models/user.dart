import 'package:todo_list/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User{
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  List<Task>? tasks;

  User({required this.firstname, required this.lastname, required this.email, required this.password, String? pid}) : tasks = [], id=uuid.v4(){
    id= pid ??id;
  }

  @override
  String toString() {
    return "Task(Firstname: $firstname, Lastname: $lastname, ID: $id)";
  }

}


