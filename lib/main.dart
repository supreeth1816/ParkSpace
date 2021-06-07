import 'package:flutter/material.dart';
import 'package:parkspace/screens/selectLocationScreen.dart';
import 'screens/vendorScreen.dart';
import 'screens/userScreen.dart';
import 'screens/startScreen.dart';
import 'screens/statusScreen.dart';
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

          '/vendor': (context) => VendorScreen(),
          '/user': (context) => UserScreen(),
          '/status': (context) => StatusScreen(),
          '/selectlocation': (context) => SelectLocationScreen(),

        },
      );

  }
}
