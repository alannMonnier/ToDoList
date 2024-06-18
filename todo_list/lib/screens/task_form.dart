import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:uuid/uuid.dart';

import '../models/task.dart';
import '../todolist_app.dart';

var uuid = const Uuid();
enum FormMode {Add, Edit}

class TaskForm extends StatefulWidget {

  final FormMode formMode;
  final Task? task;

  const TaskForm({Key? key, required this.formMode, this.task}) : super(key:key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm>{

  // Objets qui possède les informations sur le formulaire courant
  final _formKey = GlobalKey<FormState>();
  // Création de noms pour les champs du formulaire
  final contentNameController = TextEditingController();
  final auteurNameController = TextEditingController();
  final titleNameController = TextEditingController();
  var completed = false;
  // Gestion des tags
  String prioriteController = "normal";
  DateTime selectedDueDate = DateTime.now();
  DateTime selectedUpdatedDate = DateTime.now();


  // Initialise les valeurs associés au champs du formulaire
  @override
  void initState() {
    super.initState();
    // Formulaire de modifications d'une tâche
    if(widget.formMode == FormMode.Edit && widget.task != null){
      // ?? si contenue avant est nulle lui donne une valeur par défault
      contentNameController.text = widget.task!.content ?? "";
      auteurNameController.text = widget.task!.userid ?? "";
      titleNameController.text =  widget.task?.title ?? "";
      prioriteController = widget.task!.priority ?? "low";
      selectedDueDate = widget.task?.dueDate ?? DateTime.now();
      selectedUpdatedDate = widget.task?.updatedAt ?? DateTime.now();
      completed = widget.task!.completed!;
    }else{
      // Formulaire ajout d'une tâche
      contentNameController.text =  "";
      auteurNameController.text =  "";
      prioriteController = "low";
    }
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


  DateTimeFormField _dateTimeFormField(DateTime dateTime){
    return DateTimeFormField(
        decoration: const InputDecoration(
          labelText: 'Choisir une Date',
          border: OutlineInputBorder(),
        ),
        mode: DateTimeFieldPickerMode.date,
        initialValue: dateTime,
        initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
        onChanged: (DateTime? value) {
          setState((){
            dateTime = value!;
          });
        },
        validator: (val) {
          if (val == null || val.isUtc) {
            return "Ce champs est requis";
          } else {
            return null;
          }
        }
    );
  }



  @override
  Widget build(BuildContext context) {
    return Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child) {
                child:
                return SingleChildScrollView(
                  child: Column(
                    children: [
                  
                        if(widget.formMode == FormMode.Edit || widget.formMode == FormMode.Add) ...[
                  
                          Text("Id : ${widget.task?.id}"),
                          Text("Date de création : ${widget.task?.createdAt}"),
                  
                  
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
                            child: _dateTimeFormField(selectedDueDate)
                          ),
                  
                        ],
                      if(widget.formMode == FormMode.Edit) ...[
                        Row(
                          children: [
                            const Text("Complété : "),
                            Checkbox(
                              value: widget.task?.completed,
                              onChanged: (bool? value) {
                                setState((){
                                  widget.task?.completed = value!;
                                  completed = value !;
                                });
                              },
                            ),
                          ],
                        ),

                  
                          // Form pour le titre
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: _textFormField("Titre", "titre", titleNameController),
                          ),
                  
                          Container(
                              margin: const EdgeInsets.all(20),
                              child: _dateTimeFormField(selectedUpdatedDate)
                          ),
                      ],
                  
                  
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                // Si le formulaire est validé
                                if (_formKey.currentState!.validate()) {
                  
                                  if(widget.formMode == FormMode.Edit){
                  
                                      widget.task?.setAttributes(
                                          auteurNameController.text, contentNameController.text, completed,
                                          selectedUpdatedDate, selectedDueDate, prioriteController, titleNameController.text
                                      );
                  
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text("La tâche a été modifié !"))
                                      );
                  
                                      // Redirection vers la page d'accueil
                                      Navigator.pop(context, {'task' : widget.task, 'modif' : true});
                                  }
                                  else{
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
                                            content: Text("La tâche a été ajouté !"))
                                    );
                  
                                    // Redirection vers la page d'accueil
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(builder: (
                                          context) => const TodoListApp()),
                                          (route) => false,
                                    );
                                  }
                                }
                              },
                              child: const Text("Valider"),
                            )
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
    );
  }
}
