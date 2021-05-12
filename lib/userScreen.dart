import 'dart:async';
import 'marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'drawer.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserScreen extends StatefulWidget {

  @override
  _UserScreenState createState() => _UserScreenState();
}



class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  //initialising the controller for google map
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController _controller;

 // var containerHeight = 220.0;


  // List of all markers
  Map<MarkerId, Marker> myMarkers= <MarkerId , Marker>{};
  Set<Marker> _markers = {

  };


  // Getting multiple markers from firebase
  void initMarker(specify, specifyId) async {
    var markerIdVal = specifyId;
    final MarkerId myMarkerId = MarkerId(markerIdVal);
    final Marker myMarker = Marker(
        markerId: myMarkerId,
        position: LatLng(specify['location'].latitude, specify['location'].longitude),
        infoWindow: InfoWindow(title: specify['address'], snippet: specify['price']),
        icon: mapMarker,

    );

    setState(() {
      myMarkers[myMarkerId] = myMarker;
    });
  }


  getMarkerData() async {
    FirebaseFirestore.instance.collection('data').get().then((myMockData) {
      if(myMockData.docs.isNotEmpty){
        for(int i=0; i < myMockData.docs.length; i++){
          initMarker(myMockData.docs[i].data, myMockData.docs[i].id);
        }
      }
    });
  }


  @override
  void initState() {
    getMarkerData();
    setCustomMarker();
    super.initState();

  }



  void _onMapCreated(GoogleMapController controller) {

  _controllerGoogleMap.complete(controller);
  _controller = controller;
  isMapCreated = true;
  locatePosition();
  getMapMode();

  // _setMapPins();

  setState(() {

    _markers.add(
        Marker(
          markerId: MarkerId("parking - 1"),
          position: LatLng(12.9717, 79.1594),
          icon: mapMarker,
          infoWindow: InfoWindow(
            title: "New Parking Slot",
            snippet: "Rs 150/hr"
          ),
        )

    );
  });
  }

  Position currentPosition;
  var geoLocator = Geolocator();


  //Method called when map is initialised
  void locatePosition() async
  {

    //position is method variable
    //currentPosition is file variable
    //getting position through inbuilt method of geolocator class

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;
    LatLng myPos = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
        target: myPos,
        zoom: 16.4746);
    
    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  bool isMapCreated = false;


  //default location
  static final LatLng myLocation = LatLng(13.9717, 79.1594);
  //zoom for the default location
  final CameraPosition parkingLocation = CameraPosition(
    target: myLocation,
    zoom: 16.4746,
  );


  //Setting Map Style
  getMapMode() {
    getJsonFile("assets/map_style.json").then(setMapStyle);
  }


  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }



  String searchAddress;

  //Method called when search button is clicked
  searchAndNavigate(){
      print(searchAddress);
      _controller.animateCamera(CameraUpdate.newCameraPosition(parkingLocation));

      print(myMarkers);
      FirebaseFirestore.instance
          .collection('test')
          .add({'text': 'data added through app'});
  }

  verticalDrag(){
    print("Vertically trying to drag");
  //  containerHeight = 200.0;
  }


  @override
  Widget build(BuildContext context) {

    if (isMapCreated) {
      getMapMode();
    }
    return Scaffold(
      extendBodyBehindAppBar: true,



      key: _scaffoldKey,

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


                        child: GoogleMap(
                          trafficEnabled: true,
                          mapType: MapType.normal,
                          zoomControlsEnabled: true,
                          myLocationButtonEnabled: false,
                          myLocationEnabled: true,
                          zoomGesturesEnabled: true,
                          onMapCreated: _onMapCreated,
                          //  markers: Set<Marker>.of(myMarkers.values),
                          markers: _markers,
                          initialCameraPosition: parkingLocation,
                        ),
                      ),

                      Stack(
                        children: [
                          Positioned(
                            left: 20.0,
                            right: 20.0,
                            top: 25.0,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                              height: 54.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(14.0),
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
                            left: 62.0 + 10,
                            right: 30.0 + 10,
                            top: 25.0 + 3,
                            child: Container(
                              width: 250,
                              child: TextField(

                                onTap: (){
                                  print("Text field is tapped");
                                },

                                onChanged: (val){

                                  // print("Value changed : ");
                                  // print(searchAddress);
                                  setState(() {
                                    searchAddress = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: "Where do you go?",
                                  border: InputBorder.none,

                                  suffix: GestureDetector(
                                    child: Text("Search",
                                      style: TextStyle(
                                          color: Colors.blueAccent,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold
                                      ),),
                                    onTap: searchAndNavigate,
                                  ),
                                ),
                              ),
                            ),

                          ),
                        ],
                      ),



                      //Bottom Tabs


                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: Container(

                            padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            //height: containerHeight,
                          height: 220.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40.0),
                                topRight: Radius.circular(40.0)
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12.withOpacity(0.1),
                                  blurRadius: 30.0,
                                  offset: Offset(
                                    0,-20
                                  ),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                GestureDetector(

                                 // onTap: verticalDrag,
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

      appBar: AppBar(
            centerTitle: true,

            //AppBar Title
            title: Text("ParkSpace", style: TextStyle(color: Colors.deepPurple),),
            backgroundColor: Colors.transparent,

            //Hamburger Menu icon
            leading: IconButton(
              icon: Icon(Icons.menu),
              color: Colors.deepPurple,
              onPressed: () => _scaffoldKey.currentState.openDrawer(),

            ),

           // shadowColor: Colors.white,
            elevation: 0,

          ),

        drawer: MyDrawer(),


    );
  }
}


