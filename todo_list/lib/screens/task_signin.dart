import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../todolist_app.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  // Création de noms pour les champs du formulaire
  final userNameController = TextEditingController();
  final mdpNameController = TextEditingController();

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
      body: Card(
        child: Column(
          children: [
            const Text("Sign In"),
            Container(
              margin: const EdgeInsets.all(20),
              child: _textFormField("Username", "username", userNameController),
            ),


            Container(
              margin: const EdgeInsets.all(20),
              child: _textFormField("Password", "password", mdpNameController),
            ),


            Container(
              margin: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Si le formulaire est validé
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Welcome!"))
                        );

                        // Redirection vers la page d'accueil
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const TodoListApp()),
                              (route) => false,
                        );
                      }
                    },
                    child: const Text("Valider"),
                  ),
              ),
            )

          ],
        ),
      ),
    );
  }
}

