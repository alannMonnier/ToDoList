import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';

import 'todolist_app.dart';

void main() {
  runApp(
      ChangeNotifierProvider(
        create: (context) => TaskProvider(),
        child : const TodoListApp(),
    ),
  );
}
