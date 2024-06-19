import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';

import 'models/task.dart';



class TodoListApp extends StatefulWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  State<TodoListApp> createState() => _TodolistAppState();
}

class _TodolistAppState extends State<TodoListApp> {

  int _currentIndexPage = 0;


  // Change l'index de la page de l'application
  setCurrentIndexPage(int index){
    setState(() {
      _currentIndexPage = index;
    });
  }


  // Affiche le TaskForm dans un dialog
  void dialogTaskForm(BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return const AlertDialog(
            content: TaskForm(formMode: FormMode.Add),
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    // Ajoute le changeNofitifier Provider pour que TaskForm est accès au notifier provider
    return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: [
                const Text("Accueil : ToDoList Application"), const Text("Formulaire: Ajout d'une tâche")
              ][_currentIndexPage],
            ),

            body: [
              // Liste des pages ou l'on peut naviguer
              const TaskMaster(),
              // Met widget vide pour qu'il y est quand meme un incrément de l'index de la page pour pouvoir afficher le dialogTaskForm
              const TaskForm(formMode: FormMode.Add),
            ][_currentIndexPage], // Pointe vers une pages en fonction de l'index

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndexPage, // Numéro de la page courante
              // Change l'index la page courante en cliquant sur un des elements de la barre de navigation
              onTap: (index) => {
                setCurrentIndexPage(index),
              },
              /**
              onTap: (index) => {
                // Si on clique sur ajouter affiche un widget Dialog
                if(index == 1){
                 dialogTaskForm(context),
                }
                else{
                  setCurrentIndexPage(index),
                }
              },*/

              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              iconSize: 32,
              elevation: 15,
              // Ombres
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Accueil",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: "Ajouter tâche",
                ),
              ],
            ),
          ),
    );
  }
}




