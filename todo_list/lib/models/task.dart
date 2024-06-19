import 'dart:math';

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

  // Récupère l'id de la tache
  String? getId(){
    return id;
  }

  void setAttributes(String userid, String content, bool completed, DateTime updatedAt, DateTime dueDate, String priority, String title){
    this.userid = userid;
    this.content = content;
    this.completed = completed;
    this.updatedAt = updatedAt;
    this.dueDate = dueDate;
    this.priority = priority;
    this.title = title;
  }


  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
        pid : json['idTask'] as String,
        userid : json['userid'] as String,
        content : json['content'] as String,
        completed : json['completed'] as bool,
        dueDate : DateTime.parse(json['dueDate'] as String),
        priority : json['priority'] as String,
        pTitle : json['title'] as String,
    );
  }


  Map<String, dynamic> toJson() => {
    'idTask' : id,
    'userid' : userid,
    'content' : content,
    'completed' : completed,
    'dueDate' : dueDate?.toIso8601String(),
    'priority' : priority,
    'title' : title
  };


  @override
  String toString() {
    return "Task(content:$content, id:$id)";
  }

}


