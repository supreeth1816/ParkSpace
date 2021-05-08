import 'package:flutter/material.dart';
import 'signUpScreen.dart';
import 'userScreen.dart';
import 'startScreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
