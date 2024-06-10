import 'package:flutter/material.dart';

class Master extends StatelessWidget {
  const Master({super.key});

  get onPressed => null;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hello World!'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: onPressed,
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
      ),
    );
  }
}
