import 'package:todo_list/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Tag{
  String? idTag;
  String? value;
  String? userid; // Auteur
  List<Task>? tasks;


  Tag({required this.value, required this.userid, String? pid}) : tasks = [], idTag=uuid.v4(){
    idTag= pid ??idTag;
  }

  @override
  String toString() {
    return "Task(Value: $value, id:$idTag)";
  }

}


