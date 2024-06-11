import 'package:todo_list/models/tag.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class Task{
  String? id;
  String? userid; // Auteur
  String? content;
  List<Tag>? tags;
  bool? completed; // Status de réalisation
  DateTime? createdAt; // Date création
  DateTime? updatedAt; // Date mise à jour
  DateTime? dueDate; // Date limite de réalisation
  String? priority; // Niveau priorité : low / normal / high
  String? title;


  Task({ required this.content, required this.userid, required this.dueDate, required this.priority,
    String? pTitle, String? pid, this.completed = false }) : id=uuid.v4(), tags =[], createdAt = DateTime.now(){
        id= pid ??id;
  }

  @override
  String toString() {
    return "Task(content:$content, id:$id)";
  }

}


