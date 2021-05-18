import '../widgets/marker.dart';
import 'package:flutter/material.dart';
import '../widgets/drawer.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/navTitle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:parkspace/mapData.dart';



class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  //initialising the controller for google map
  var _isBike = false;
  var _isCar = true;
  var color1 = Colors.deepPurple;
  var color2 = Colors.grey;

  @override
  void initState() {
  //  getMarkerData();
    setCustomMarker();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      key: _scaffoldKey,


      appBar: AppBar(

        centerTitle: true,

        //AppBar Title
        title: NavTitle(),
        backgroundColor: Colors.white,

        //Hamburger Menu icon
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.bars,
            size: 19,
          ),
          color: Colors.deepPurple,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),

        ),

        actions: <Widget>[

          Column(
            children: [
              SizedBox(height: 4,),
              Container(
                padding: EdgeInsets.only(bottom: 0),
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    FontAwesomeIcons.carAlt,
                    size: 20,

                  ),
                  color: _isCar ? Colors.deepPurple : Colors.grey,

                  onPressed: () {
                    setState(() {
                      _isCar = true;
                      _isBike = false;
                    });
                    print("Selected Car");
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.only(top: 0),
                height: 3.0,
                width: 12.0,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: _isCar ? Colors.deepPurple : Colors.transparent,
                ),
              ),
            ],
          ),

          Container(
            padding: EdgeInsets.only(right: 8),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 3, top: 2),

                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    icon: Icon(
                      FontAwesomeIcons.biking,
                      size: 17,
                    ),
                    color: _isBike ? Colors.deepPurple : Colors.grey,

                    onPressed: () {
                      setState(() {
                        _isBike = true;
                        _isCar = false;
                      });
                      print("Selected Bike");
                    },
                  ),
                ),

                Container(
                  padding: EdgeInsets.only(top: 0, left: 0),
                  height: 3.0,
                  width: 12.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _isBike ? Colors.deepPurple : Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],

        elevation: 0,
      ),

      // shadowColor: Colors.white,
      drawer: MyDrawer(),

      body: SafeArea(
        child: SingleChildScrollView(
          //padding: EdgeInsets.only(top: 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height - 102,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      // Google Map
                      Container(
                        height: MediaQuery.of(context).size.height - 202,

                        child: MapData(),
                      ),

                      Stack(
                        children: [
                          Positioned(
                            left: 22.0,
                            right: 22.0,
                            top: 20.0,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                              height: 54.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 30.0,
                                    offset: Offset(0,10),
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.search, color: Colors.blueAccent,),
                                  SizedBox(width: 10),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            left: 62.0 + 12,
                            right: 30.0 + 12,
                            top: 23.0,
                            child: Container(
                              width: 250,
                              child: TextField(
                                onTap: (){
                                  print("Text field is tapped");
                                },
                                onChanged: (val){
                                  setState(() {
                                    searchAddress = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Where do you go?",
                                  hintStyle: GoogleFonts.quicksand(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black38
                                  ),
                                  border: InputBorder.none,

                                  suffix: GestureDetector(
                                    child: Text("Search",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    onTap: searchAndNavigate,
                                  ),),),),),
                        ],
                      ),


                      //Main Bottom View
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(18, 10, 16, 10),
                            //height: containerHeight,
                          height: 270.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.07),
                                  blurRadius: 30.0,
                                  offset: Offset(
                                    0,-20
                                  ),),
                              ],
                            ),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                //Grey Pull Button
                                GestureDetector(
                                  onTap: getAllMarkers,
                                  child: Container(
                                    width: 44.0,
                                    height: 7.0,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.all(
                                       Radius.circular(10.0),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: 6,),

                                //Parking details tile
                                ListTile(
                                  contentPadding: EdgeInsets.only(top: 10, bottom: 0, left: 16, ),
                                  title: Container(
                                    padding: EdgeInsets.only(bottom: 6),
                                    child: Text(
                                      "Alex's Parking Space",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 20.0,
                                        color: Color(0xff7248bc),
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Rs. 216.06/h",
                                    style: GoogleFonts.quicksand(
                                      color: Color(0xff8A8A8A),
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
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
                                                  color: Color(0xff33c642),
                                                ),
                                              ),
                                              SizedBox(width: 9,),
                                              Text(
                                                "Available",
                                           style: GoogleFonts.quicksand(
                                             color: Color(0xff33c642),
                                             fontWeight: FontWeight.w500,
                                           ),
                                           //     style: whiteSubHeadingTextStyle.copyWith(color: Colors.green, fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(

                                            children: [
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                //Select time tile
                                ListTile(
                                  contentPadding: EdgeInsets.only(top: 0, bottom: 0),
                                  title: Container(
                                    padding: EdgeInsets.only(bottom: 2),
                                    child: Text(
                                      "Select Time",
                                      style: GoogleFonts.quicksand(
                                        fontSize: 16.0,
                                        color: Color(0xff868686),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    "Today, 2:00 PM"
                                        ,style: GoogleFonts.quicksand(
                                    color: Color(0xff8a8a8a),
                                  ),
                                  ),
                                  leading: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Image.asset(
                                        "assets/time.png",
                                        width: 48,
                                        height: 48,
                                      ),

                                  ),
                                  trailing: SizedBox(
                                    width: 68,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[

                                              SizedBox(width: 10,),
                                              Icon(Icons.keyboard_arrow_down_rounded, size: 29,
                                                color: Color(0xff8a8a8a),),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),

                                Container(
                                  height: 1,
                                  margin: EdgeInsets.only(left: 10, right: 12),
                                  color: Color(0xffe4e4e4),
                                ),


                                Container(
                                  padding: EdgeInsets.only(top: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      Container(

                                        width: 120,
                                        margin: EdgeInsets.only(left: 30,right: 10),
                                        child:
                                        Text("More Details",
                                        style: GoogleFonts.quicksand(
                                          fontSize: 17,
                                          color: Color(0xffaf76ea),
                                          fontWeight: FontWeight.w800


                                        ),
                                        ),
                                      ),


                                      Container(
                                      //  width: 150,
                                        padding: EdgeInsets.only(top: 14, bottom: 14, left: 54, right: 54),
                                        margin: EdgeInsets.only(left: 10),

                                        decoration: BoxDecoration(
                                          color: Color(0xffaf76ea),
                                          borderRadius: BorderRadius.circular(12),

                                        ),
                                        child:
                                        Text("Book Slot",
                                        style: GoogleFonts.quicksand(
                                          color: Colors.white,
                                          fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                        ),),
                                      ),
                                    ],
                                  ),
                                )
                                // _buildLocationInfo(),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
String searchAddress;
