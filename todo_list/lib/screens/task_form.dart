import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/task_master.dart';
import 'package:todo_list/services/task_service.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../todolist_app.dart';

var uuid = const Uuid();


class TaskForm extends StatefulWidget {



  const TaskForm({super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm>{

  // Objets qui possède les informations sur le formulaire courant
  final _formKey = GlobalKey<FormState>();
  // Création de noms pour les champs du formulaire
  final contentNameController = TextEditingController();
  final auteurNameController = TextEditingController();
  String prioriteController = "";
  DateTime selectedDueDate = DateTime.now();

  // Initialise les valeurs associés au champs du formulaire
  @override
  void initState() {
    super.initState();
    contentNameController.text = "Content";
    auteurNameController.text = "Auteur";
    prioriteController = "low";
  }

  TextFormField _textFormField(String label, String hintText, TextEditingController tec){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "$label : ",
        hintText: "Entrez un $hintText: ",
        border: const OutlineInputBorder(),
      ),
      cursorColor: Colors.green,
      // Ajout de validators pour vérifier les informations entrées
      validator: (val){
        if(val == null || val.isEmpty){
          return "Ce champs est requis";
        }else{
          return null;
        }
      },
      controller: tec, // Valeur du champ qu'on récupère grâce au contrôleur
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                child:
                return Column(
                  children: [
                    // Form pour le content
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: _textFormField(
                          "Content", "content", contentNameController),
                    ),

                    // Form pour l'auteur
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: _textFormField(
                          "Auteur", "auteur", auteurNameController),
                    ),


                    // Form pour le champ Priority
                    Container(
                        margin: const EdgeInsets.all(20),
                        child: DropdownButtonFormField(
                          items: const [
                            DropdownMenuItem(value: "low", child: Text("Low")),
                            DropdownMenuItem(value: "normal", child: Text(
                                "Normal")),
                            DropdownMenuItem(value: "high", child: Text(
                                "High")),
                          ],
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Sélectionnez une priorité",
                          ),
                          value: prioriteController,
                          onChanged: (value) {
                            setState(() {
                              prioriteController = value!;
                            });
                          },
                        )
                    ),


                    // Champ pour la date de fin de la tâche
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: DateTimeFormField(
                          decoration: const InputDecoration(
                            labelText: 'Choisir une Date',
                            border: OutlineInputBorder(),
                          ),
                          mode: DateTimeFieldPickerMode.date,
                          initialPickerDateTime: DateTime.now().add(
                              const Duration(days: 20)),
                          onChanged: (DateTime? value) {
                            setState(() {
                              selectedDueDate = value!;
                            });
                          },
                          validator: (val) {
                            if (val == null || val.isUtc) {
                              return "Ce champs est requis";
                            } else {
                              return null;
                            }
                          }
                      ),
                    ),


                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Si le formulaire est validé
                              if (_formKey.currentState!.validate()) {
                                // Création de la tâche
                                final task = Task(
                                    pid: uuid.v4(),
                                    content: contentNameController.text,
                                    userid: auteurNameController.text,
                                    dueDate: selectedDueDate,
                                    priority: prioriteController
                                );

                                taskProvider.addTask(task);

                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("La tâche a été ajoutée!"))
                                );

                                // Redirection vers la page d'accueil
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(builder: (
                                      context) => const TodoListApp()),
                                      (route) => false,
                                );
                              }
                            },
                            child: const Text("Valider"),
                          )
                      ),
                    )
                  ],
                );
              },
            ),
          ),
      ),
    );
  }
}
