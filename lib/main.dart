import 'package:flutter/material.dart';
import 'signUpScreen.dart';
import 'userScreen.dart';
import 'startScreen.dart';

void main() {
  runApp(
      ParkspaceApp());

}

class ParkspaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: StartScreen(),

        routes: {

          '/vendor': (context) => SignUpScreen(),
          '/user': (context) => UserScreen(),

        },
      );

  }
}
