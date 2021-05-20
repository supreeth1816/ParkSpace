
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//final databaseReference = FirebaseDatabase.instance.reference();

class StatusGraph extends StatefulWidget {


  @override
  _StatusGraphState createState() => _StatusGraphState();
}

class _StatusGraphState extends State<StatusGraph> {
  static List<double> baseData = [0, 0];
  static List<double> dataSetA = <double>[];
  static List<double> dataSetB = <double>[];
  static bool switchDataSet = false;
  final int sizeOfArray = 10;


  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse("https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"));
    print(json.decode(response.body));
  }

  // void createRecord(){
  //   databaseReference.child("1").set({
  //     'title': 'Mastering EJB',
  //     'description': 'Programming Guide for J2EE'
  //   });
  //   databaseReference.child("2").set({
  //     'title': 'Flutter in Action',
  //     'description': 'Complete Programming Guide to learn Flutter'
  //   });
  // }
  //
  // void addData() {
  //   databaseReference.push().set({'name': 'abc', 'comment': 'A good season'});
  // }
  //
  // void readData(){
  //   print("Reading data: ");
  //   print(databaseReference);
  //
  //   databaseReference.once().then((DataSnapshot snapshot) {
  //     print('Data : ${snapshot.value}');
  //   });
  // }

  List<double> setDataSet(List<double> currentDataSet,
      List<double> previousDataSet, double newData) {
    currentDataSet.clear();
    currentDataSet.addAll(previousDataSet);
    currentDataSet.add(newData);
    if (currentDataSet.length >= sizeOfArray) {
      for (int i = 0; i <= currentDataSet.length - sizeOfArray; i++) {
        currentDataSet.removeAt(i);
      }
    }
    return currentDataSet;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

          MaterialButton(onPressed: fetchData,
          child: Text("Click to add data"),),


        ],

      ),
    );
  }
}
