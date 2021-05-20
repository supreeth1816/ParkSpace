
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';

//final databaseReference = FirebaseDatabase.instance.reference();



class StatusGraph extends StatefulWidget {


  @override
  _StatusGraphState createState() => _StatusGraphState();
}

class _StatusGraphState extends State<StatusGraph> {

  List<double> chartData1 = <double>[
    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
  ];
  ChartSeriesController _chartSeriesController;

  Timer timer;
  int count = 19;

  final int sizeOfArray = 10;


  void _updateDataSource(Timer timer) async{

    int a = chartData1.length - 1;


    final response = await http
        .get(Uri.parse(
        "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"));
    double distance = json.decode(response.body).toDouble();
    chartData1.add(distance);

    if (chartData1.length >= 10) {
      // Removes the last index data of data source.
      chartData1.removeAt(0);
      // Here calling updateDataSource method with addedDataIndexes to add data in last index and removedDataIndexes to remove data from the last.
      _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[a],
          removedDataIndexes: <int>[0]);
    }
    count = count + 1;
  }


  Future<void> fetchDistance() async {
    final response = await http
        .get(Uri.parse(
        "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"));
    int distance = json.decode(response.body);
    return distance;
   // print(distance);
  }


  void chart() {
    print(chartData1);
}

  @override
  Widget build(BuildContext context) {
    timer =
        Timer.periodic(const Duration(milliseconds: 1000), _updateDataSource);
    return StreamBuilder<List<double>>(
        stream: null,
        builder: (context, snapshot) {
          return Container(
            child: Column(
              children: [

                MaterialButton(onPressed: fetchDistance,
                  child: Text("Click to add data"),),

                MaterialButton(onPressed: chart,
                  child: Text("Click to add data"),),


                Container(
                    height: 100, width: 356,
                    margin: EdgeInsets.only(right: 20, left: 20),
                   padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xfff3e7ff),
                    ),
                  child: Sparkline(
                      //fallbackHeight: 80,
                        data: chartData1,
                      lineWidth: 3,
                      lineColor: Color(0xffa647e9),
                    ),
                  ),


              ],

            ),
          );
        }
    );
  }
}


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