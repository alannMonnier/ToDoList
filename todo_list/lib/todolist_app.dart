import 'package:flutter/material.dart';
import 'package:todo_list/screens/task_form.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';



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

  @override
  Widget build(BuildContext context) {
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
            const TaskForm()
          ][_currentIndexPage], // Pointe vers une pages en fonction de l'index
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndexPage, // Numéro de la page courante
            // Change l'index la page courante en cliquant sur un des elements de la barre de navigation
            onTap: (index) => {
              setCurrentIndexPage(index),
            },
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




