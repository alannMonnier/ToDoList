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

  factory Tag.fromJson(Map<String, dynamic> json){
    return Tag(
      pid : json['idTag'] as String,
      value : json['value'] as String,
      userid : json['userid'] as String,
    );
  }


  Map<String, dynamic> toJson() => {
    'idTag' : idTag,
    'value' : value,
    'userid' : userid
  };

  @override
  String toString() {
    return "Task(Value: $value, id:$idTag)";
  }

}


