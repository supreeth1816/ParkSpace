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
      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.fromLTRB(60, 100, 0, 0),

        child: Column(

          children: [
            Image.asset('assets/Logo.png',
              width: 300,

            ),
          ],
        ),
      ),
    );
  }
}
