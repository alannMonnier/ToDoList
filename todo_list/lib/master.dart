import 'package:flutter/material.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  get onPressed => null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
      ),
    );
  }
}
