import 'package:flutter/material.dart';

void main() {
  runApp(ParkspaceApp());
}

class ParkspaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(

      home: StartScreen(),
    );
  }
}


class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Text("Parkspace App"),
      ),
    );
  }
}
