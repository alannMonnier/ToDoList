import 'package:flutter/material.dart';

import '../models/task.dart';

class TaskDetails extends StatefulWidget {

  final Task task;

  const TaskDetails({super.key, required this.task});

  @override
  State<TaskDetails> createState() => _DetailsState();
}

class _DetailsState extends State<TaskDetails> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
