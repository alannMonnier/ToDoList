import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();
final _formKey = GlobalKey<FormState>();

class TaskForm extends StatelessWidget {


  const TaskForm({super.key});


  TextFormField _textFormField(String label, String hintText){
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
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Form pour le content
              Container(
                margin: const EdgeInsets.all(20),
                child: _textFormField("Content", "content"),
              ),

              // Form pour l'auteur
              Container(
                margin: const EdgeInsets.all(20),
                child: _textFormField("Auteur", "auteur"),
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
                      value: "low",
                      decoration: const InputDecoration(
                          border: OutlineInputBorder()
                      ),
                      onChanged: (value){}
                  )
              ),


              // Champ pour la date de fin de la tâche
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Date',
                ),
                firstDate: DateTime.now().add(const Duration(days: 10)),
                lastDate: DateTime.now().add(const Duration(days: 40)),
                initialPickerDateTime: DateTime.now().add(const Duration(days: 20)),
                onChanged: (DateTime? value) {
                  //selectedDate = value;
                },
              ),


              Container(
                margin: const EdgeInsets.only(top:10),
                child : SizedBox(
                    width: double.infinity,
                    child : ElevatedButton(
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Envoie en cours..."))
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
      ),
    );
  }
}
