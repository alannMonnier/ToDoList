import 'package:todo_list/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Tag{
  String? id;
  String? value;
  String? userid; // Auteur
  List<Task>? tasks;


  Tag({required this.value, required this.userid, String? pid}) : tasks = [], id=uuid.v4(){
    id= pid ??id;
  }

  @override
  String toString() {
    return "Task(Value: $value, id:$id)";
  }

}


