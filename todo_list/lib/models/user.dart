import 'package:todo_list/models/task.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

class User{
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  List<Task>? tasks;

  User({required this.firstname, required this.lastname, required this.email, required this.password, String? pid}) : tasks = [], id=uuid.v4(){
    id= pid ??id;
  }


  factory User.fromJson(Map<String, dynamic> json){
    return User(
      pid : json['id'] as String,
      firstname : json['firstname'] as String,
      lastname : json['lastname'] as String,
      email : json['email'] as String,
      password : json['password'] as String,
    );
  }


  Map<String, dynamic> toJson() => {
    'id' : id,
    'firstname' : firstname,
    'lastname' : lastname,
    'email' : email,
    'password' : password
  };

  @override
  String toString() {
    return "Task(Firstname: $firstname, Lastname: $lastname, ID: $id)";
  }

}


