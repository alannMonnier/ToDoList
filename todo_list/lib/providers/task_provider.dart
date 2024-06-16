
import 'package:flutter/cupertino.dart';

import '../models/task.dart';

class TaskProvider extends ChangeNotifier{

  // Liste des tâches
  List<Task> _tasks = [];


  // Récupère la liste de tâches
  List<Task> getList(){
    return _tasks;
  }

  // Ajoute une tâche dans la liste
  void addTask(Task task){
    _tasks.add(task);
    notifyListeners();
  }

  // Supprime une tâche dans la liste via son id
  void removeTaskById(String idTask){
    _tasks.removeWhere((elt) => elt.id == idTask);
    notifyListeners();
  }

  // Supprime une tâche dans la liste en passant une tache en paramètre
  void removeTask(Task task){
    _tasks.remove(task);
    notifyListeners();
  }


  // Récupère une tâche via son id
  Task? getTaskById(String idTask){
    for(var i=0; i< _tasks.length; i++){
      if(_tasks[i].id == idTask){
        return _tasks[i];
      }
    }
    return null;
  }

  // Modifie une tâche via son index dans la liste
  void updatedTask(String? idTask, Task task){
    for(var i=0; i< _tasks.length; i++){
      if(_tasks[i].id == idTask){
        _tasks[i] = task;
        notifyListeners();
        break;
      }
    }
  }


  // Créer une liste de tâche
  void createListTasks(List<Task> tasks){
    _tasks = tasks;
    notifyListeners();
  }

}
