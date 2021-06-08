import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkspace/widgets/statusGraph.dart';
import '../widgets/drawer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';



class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {

  @override
  void initState() {
    // TODO: implement initState
    _updateDataSource();
    super.initState();
  }

  final TextStyle whiteNameTextStyle = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  final TextStyle whiteSubHeadingTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  final TextStyle actionMenuStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    letterSpacing: 5,
  );



  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  ChartSeriesController _chartSeriesController;
  List<double> chartData1 = <double>[
    1, 8, 24, 6, 10, 152, 330, 20, 40, 1
  ];

  int count = 19;

  var slotindex1text = "Slot Filled";
  var slotindex1price = "106.20";
  var slotColor = Colors.grey;






  void _updateDataSource() async {

    int a = chartData1.length - 1;

    final response = await http
        .get(Uri.parse(
        "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/slotindex1/parkingdistance.json"));
    double distance = json.decode(response.body).toDouble();
    chartData1.add(distance);

    if (chartData1.length >= 10) {

      // Removes the last index data of data source.
      chartData1.removeAt(0);

      _chartSeriesController?.updateDataSource(
          addedDataIndexes: <int>[a],
          removedDataIndexes: <int>[0]);
    }
    count = count + 1;

    var doublePrice = double.parse(slotindex1price);


    if (chartData1[9] < 20){
      setState(() {
        slotindex1text = "Slot Filled";
        doublePrice += 1.0;
        slotindex1price = doublePrice.toString();
        slotColor = Colors.green;

      });
    }
    else if(chartData1[9] > 20){
      setState(() {
        slotindex1text = "Slot Empty";
        slotColor = Colors.grey;
      });
    }

    print(chartData1);
  }



  Future<void> fetchDistance() async {
    final response = await http
        .get(Uri.parse(
        "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/slotindex1/parkingdistance.json"));
    int distance = json.decode(response.body);
    return distance;
    // print(distance);
  }


  Future<void> fetchStatus() async {
    final response = await http
        .get(Uri.parse(
        "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/slotindex1/parkingstatus.json"));
    String status = json.decode(response.body);
    return status;
    // print(distance);
  }

  void chart() {
    print(chartData1);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      drawer: MyDrawer(),

      appBar: AppBar(


        centerTitle: true,

        //AppBar Title
        title: Text("Parking Status", style: GoogleFonts.quicksand(color: Colors.deepPurple, fontWeight: FontWeight.w800, fontSize: 18), ),
        backgroundColor: Colors.white,

        //Hamburger Menu icon
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.deepPurple,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),

        ),

        shadowColor: Colors.white,
        elevation: 0,

        actions: <Widget>[
      IconButton(
      splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: Icon(
          Icons.refresh,
          size: 20,
           color: Colors.deepPurple,
        ),
        onPressed: _updateDataSource,
      ),
        ],

      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20,),

        //Status Graph
        Container(
          child: Column(
            children: [

              // MaterialButton(onPressed: fetchDistance,
              //   child: Text("Click to add data"),),
              //
              // MaterialButton(onPressed: chart,
              //   child: Text("Click to add data"),),

              Container(
                  height: 140, width: 356,
                  margin: EdgeInsets.only(right: 20, left: 20),
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xfff3e7ff),
                  ),
                  child: GestureDetector(
                    onTap: _updateDataSource,
                    child: Sparkline(
                      //fallbackHeight: 80,
                      data: chartData1,
                      pointsMode: PointsMode.last,
                      pointSize: 8.0,
                      pointColor: Color(0xff7127a7),
                      lineWidth: 3,
                      lineColor: Color(0xffa647e9),
                    ),
                  ),
                ),

            ],

          ),
        ),

            //Slot name
            Padding(
              padding: const EdgeInsets.only(left: 106, right: 0, top: 20, bottom: 20),
              child: Text(
                "Alex's parking slot",
                style: GoogleFonts.quicksand(
                  fontSize: 20.0,
                  color: Color(0xff7127a7),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ),



            //View All Parking Slots
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 0,

                        shadowColor: Colors.white54,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),

                          title: Container(
                            padding: EdgeInsets.only(bottom: 6),

                            child: Text(
                              "Alex's parking slot",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black38,
                              ),
                              Text(
                                "  Vellore",
                                style: whiteSubHeadingTextStyle.copyWith(color: Colors.black38, fontSize: 14),
                              ),
                            ],
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icon.png",
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 106,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "$slotindex1text",
                                        style: whiteSubHeadingTextStyle.copyWith(color: slotColor, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(

                                    children: [
                                      Text(
                                        "₹ $slotindex1price"
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(
                                        Icons.push_pin,
                                        color: Colors.blueAccent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                       height: 1.0,
                        width: 340,
                        color: Colors.grey.shade300,
                      ),

                      Card(
                        elevation: 0,

                        shadowColor: Colors.white54,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),

                          title: Container(
                            padding: EdgeInsets.only(bottom: 6),

                            child: Text(
                              "Parking Slot 2",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black38,
                              ),
                              Text(
                                "  Vellore",
                                style: whiteSubHeadingTextStyle.copyWith(color: Colors.black38, fontSize: 14),
                              ),
                            ],
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icon.png",
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 106,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Slot Empty",
                                        style: whiteSubHeadingTextStyle.copyWith(color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(

                                    children: [
                                      Text(
                                          "₹ 0.00"
                                      ),
                                      SizedBox(width: 20,),
                                      Icon(
                                        Icons.push_pin_outlined,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: 1.0,
                        width: 340,
                        color: Colors.grey.shade300,
                      ),
                      Card(
                        elevation: 0,

                        shadowColor: Colors.white54,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),

                          title: Container(
                            padding: EdgeInsets.only(bottom: 6),

                            child: Text(
                              "Parking Slot 3",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black38,
                              ),
                              Text(
                                "  Vellore",
                                style: whiteSubHeadingTextStyle.copyWith(color: Colors.black38, fontSize: 14),
                              ),
                            ],
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icon.png",
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 106,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Slot Empty",
                                        style: whiteSubHeadingTextStyle.copyWith(color: Colors.grey, fontSize: 14),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(

                                    children: [
                                      Text(
                                          "₹ 0.00"
                                      ),
                                      SizedBox(width: 20,),
                                      Icon(
                                        Icons.push_pin_outlined,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        width: 340,
                        color: Colors.grey.shade300,
                      ),
                      Card(
                        elevation: 0,

                        shadowColor: Colors.white54,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),

                          title: Container(
                            padding: EdgeInsets.only(bottom: 6),

                            child: Text(
                              "Parking Slot 4",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black38,
                              ),
                              Text(
                                "  Vellore",
                                style: whiteSubHeadingTextStyle.copyWith(color: Colors.black38, fontSize: 14),
                              ),
                            ],
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icon.png",
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 106,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Slot Empty",
                                        style: whiteSubHeadingTextStyle.copyWith(color: Colors.grey, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(

                                    children: [
                                      Text(
                                          "₹ 0.00"
                                      ),
                                      SizedBox(width: 20,),
                                      Icon(
                                        Icons.push_pin_outlined,
                                        color: Colors.grey,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//
//
// int count = 19;
// void _updateDataSource(Timer timer) async {
//
//   int a = chartData1.length - 1;
//
//
//   final response = await http
//       .get(Uri.parse(
//       "https://parkspace-242a3-default-rtdb.asia-southeast1.firebasedatabase.app/parkingdistance.json"));
//   double distance = json.decode(response.body).toDouble();
//   chartData1.add(distance);
//
//   if (chartData1.length >= 10) {
//     // Removes the last index data of data source.
//     chartData1.removeAt(0);
//     // Here calling updateDataSource method with addedDataIndexes to add data in last index and removedDataIndexes to remove data from the last.
//     _chartSeriesController?.updateDataSource(
//         addedDataIndexes: <int>[a],
//         removedDataIndexes: <int>[0]);
//   }
//   count = count + 1;
// }
//
//
// class StatusGraph extends StatefulWidget {
//
//
//   @override
//   _StatusGraphState createState() => _StatusGraphState();
// }
//
// class _StatusGraphState extends State<StatusGraph> {
//
//
//
//
//   Timer timer;
//   int count = 19;
//
//   final int sizeOfArray = 10;
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // timer =
//     //     Timer.periodic(const Duration(milliseconds: 500), _updateDataSource);
//     return StreamBuilder<List<double>>(
//         stream: null,
//         builder: (context, snapshot) {
//           return Container(
//             child: Column(
//               children: [
//
//                 MaterialButton(onPressed: fetchDistance,
//                   child: Text("Click to add data"),),
//
//                 MaterialButton(onPressed: chart,
//                   child: Text("Click to add data"),),
//
//
//                 Container(
//                   height: 100, width: 356,
//                   margin: EdgeInsets.only(right: 20, left: 20),
//                   padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Color(0xfff3e7ff),
//                   ),
//                   child: Sparkline(
//                     //fallbackHeight: 80,
//                     data: chartData1,
//                     lineWidth: 3,
//                     lineColor: Color(0xffa647e9),
//                   ),
//                 ),
//               ],
//
//             ),
//           );
//         }
//     );
//   }
// }
