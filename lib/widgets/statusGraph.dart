import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';



//
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_core/firebase_core.dart';
//final databaseReference = FirebaseDatabase.instance.reference();
// Stream<void> distanceStream() async* {
//   while (true) {
//     await Future.delayed(Duration(milliseconds: 500));
//     double distance = (await http
//         .get(Uri.parse("https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"))) as double;
//
//     // final response = await http
//     //     .get(Uri.parse("https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"));
//     // double distance = (json.decode(response));
//     // yield distance
//
//     yield distance;
//
//
//   }
// }

// List<double> setDataSet(List<double> currentDataSet,
//     List<double> previousDataSet, double newData) {
//   currentDataSet.clear();
//   currentDataSet.addAll(previousDataSet);
//   currentDataSet.add(newData);
//   if (currentDataSet.length >= sizeOfArray) {
//     for (int i = 0; i <= currentDataSet.length - sizeOfArray; i++) {
//       currentDataSet.removeAt(i);
//     }
//   }
//   return currentDataSet;