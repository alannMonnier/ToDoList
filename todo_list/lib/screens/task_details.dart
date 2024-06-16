import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetails extends StatefulWidget {

  final Task task;


  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _DetailsState();
}

class _DetailsState extends State<TaskDetails> {

  final _formKey = GlobalKey<FormState>();

  // Création de noms pour les champs du formulaire
  final contentNameController = TextEditingController();
  final auteurNameController = TextEditingController();
  final titleNameController = TextEditingController();
  var completed = false;
  var modif = false; // Envoie a TaskMaster si une modification a eu lieu ou non
  // Gestion des tags
  String prioriteController = "normal";
  DateTime selectedDueDate = DateTime.now();
  DateTime selectedUpdatedDate = DateTime.now();

  // Initialisation des variables du formulaire
  @override
  void initState() {
    super.initState();
    contentNameController.text = (widget.task.content == null || widget.task.content!.isEmpty) ? "" : widget.task.content!;
    auteurNameController.text = (widget.task.userid == null || widget.task.userid!.isEmpty) ? "" : widget.task.userid!;
    titleNameController.text = (widget.task.title == null || widget.task.title!.isEmpty) ? "" : widget.task.title!;
    prioriteController = (widget.task.priority == null) ? "low" : widget.task.priority!;
    selectedDueDate = (widget.task.dueDate == null) ?  DateTime.now(): widget.task.dueDate!;
    selectedUpdatedDate = (widget.task.updatedAt == null) ? DateTime.now() : widget.task.updatedAt!;
    completed = widget.task.completed!;
  }

  // Retourne la couleur pour le bouton de priorité
  MaterialColor _getColorPriority(){
    if(widget.task.priority == "low"){
      return Colors.yellow;
    }else{
      return (widget.task.priority == "normal") ? Colors.orange : Colors.red;
    }
  }

  TextFormField _textFormField(String label, String hintText, TextEditingController tec) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "$label : ",
        hintText: "Entrez un $hintText: ",
        border: const OutlineInputBorder(),
      ),
      cursorColor: Colors.green,
      // Ajout de validators pour vérifier les informations entrées
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Ce champs est requis";
        } else {
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
    return  Scaffold(
      appBar: AppBar(
        title: const Text("Details Tâche"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text("Id : ${widget.task.id}"),
                Text("Date de création : ${widget.task.createdAt}"),
                Text("Complété : ?"),
                // Form pour le content
                Container(
                  margin: const EdgeInsets.all(20),
                  child: _textFormField("Content", "content", contentNameController),
                ),
        
                // Form pour l'auteur
                Container(
                  margin: const EdgeInsets.all(20),
                  child: _textFormField("Auteur", "auteur", auteurNameController),
                ),
        
                // Form pour le titre
                Container(
                  margin: const EdgeInsets.all(20),
                  child: _textFormField("Titre", "titre", titleNameController),
                ),
        
                // Form pour le champ Priority
                Container(
                    margin: const EdgeInsets.all(20),
                    child : DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(value: "low", child: Text("Low")),
                        DropdownMenuItem(value: "normal", child: Text("Normal")),
                        DropdownMenuItem(value: "high", child: Text("High")),
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Sélectionnez une priorité",
                      ),
                      value: prioriteController,
                      onChanged: (value){
                          prioriteController = value!;
                      },
                    )
                ),
        
        
                // Champ pour la date de fin de la tâche
                Container(
                  margin: const EdgeInsets.all(20),
                  child: _dateTimeFormField(selectedDueDate)
                ),
        
                Container(
                    margin: const EdgeInsets.all(20),
                    child: _dateTimeFormField(selectedUpdatedDate)
                ),
        
        
                Container(
                  margin: const EdgeInsets.only(top:10),
                  child : SizedBox(
                      width: double.infinity,
                      child : ElevatedButton(
                        onPressed: (){
                          // Si le formulaire est validé
                          if(_formKey.currentState!.validate()){
        
                            // Modifie les valeurs de la tâche courante

                            widget.task.setAttributes(
                              auteurNameController.text, contentNameController.text, completed,
                              selectedUpdatedDate, selectedDueDate, prioriteController, titleNameController.text
                            );


                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("La tâche a été modifié!"))
                            );

                            // Redirection vers la page d'accueil
                            Navigator.pop(context, {'task' : widget.task, 'modif' : true});
                          }
                        },
                        child: const Text("Save"),
                      )
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

