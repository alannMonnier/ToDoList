import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
// Objets qui possède les informations sur le formulaire courant
final _formKey = GlobalKey<FormState>();

// Création de noms pour les champs du formulaire
final contentNameController = TextEditingController();
final auteurNameController = TextEditingController();
String prioriteController = "low";
DateTime selectedDueDate = DateTime.now();


class TaskForm extends StatefulWidget {

  const TaskForm({super.key});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm>{


  TextFormField _textFormField(String label, String hintText, TextEditingController tec){
    return TextFormField(
      decoration: InputDecoration(
        labelText: "${label} : ",
        hintText: "Entrez un ${hintText}: ",
        border: OutlineInputBorder(),
      ),
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
    return Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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


              // Form pour le champ Priority
              Container(
                 margin: const EdgeInsets.only(bottom: 10),
                 child : DropdownButtonFormField(
                      items: const [
                        DropdownMenuItem(value: "low", child: Text("Low")),
                        DropdownMenuItem(value: "normal", child: Text("Normal")),
                        DropdownMenuItem(value: "high", child: Text("High")),
                      ],
                   decoration: const InputDecoration(
                       border: OutlineInputBorder()
                   ),
                      value: prioriteController,
                      onChanged: (value){
                        setState((){
                            prioriteController = value!;
                        });
                      },
                  )
              ),


              // Champ pour la date de fin de la tâche
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Choisir une Date',
                  ),
                  mode: DateTimeFieldPickerMode.time,
                  initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                  onChanged: (DateTime? value) {
                    setState((){
                      selectedDueDate = value!;
                    });
                  },
                ),
              ),


              Container(
                margin: const EdgeInsets.only(top:10),
                child : SizedBox(
                    width: double.infinity,
                    child : ElevatedButton(
                      onPressed: (){
                        // Si le formulaire est validé
                        if(_formKey.currentState!.validate()){
                          // Récupère les valeurs des champs du formulaire
                          final auteur = auteurNameController.text;
                          final contextVal = contentNameController.text;

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("La tâche a été ajouté!"))
                          );
                        }
                      },
                      child: Text("Valider"),
                    )
                ),
              )
            ],
          ),
        ),
    );
  }
}
