import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:geolocator/geolocator.dart';

import 'package:flutter/services.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  //initialising the controller for google map
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController _controller;

  Set<Marker> _markers = {};

  String searchAddress;
  BitmapDescriptor parkingIcon;

  Position currentPosition;
  var geoLocator = Geolocator();


  //Method called by clicking search button
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
  static final LatLng myLocation = LatLng(12.9165, 79.1325);

  @override
  void initState() {
    super.initState();

  }



  //zoom for the default location
  final CameraPosition _kGooglePlex = CameraPosition(
    target: myLocation,
    zoom: 16.4746,
  );


  void setCustomMapPin() async {
    parkingIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  Set<Marker> _createMarker() {
    return <Marker>[

      //Marker for default point in Google Map
      Marker(
          markerId: MarkerId("marker_1"),
          position: myLocation,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueMagenta,
          )),
    ].toSet();
  }

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

  searchAndNavigate(){
      print(searchAddress);
      _controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  @override
  Widget build(BuildContext context) {

    if (isMapCreated) {
      getMapMode();
    }

    return Scaffold(

        appBar: AppBar(
          centerTitle: true,
          title: Text("ParkSpace", style: TextStyle(color: Colors.deepPurple),),
          backgroundColor: Colors.white,

          leading: Icon(
            Icons.menu,
            color: Colors.deepPurple,

          ),

          shadowColor: Colors.white,
          elevation: 0,

        ),
        body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height - 92,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          children: [

                            // Google Map

                            GoogleMap(

                              trafficEnabled: true,
                              mapType: MapType.normal,
                              zoomControlsEnabled: true,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              zoomGesturesEnabled: true,
                              markers: _createMarker(),

                              initialCameraPosition: _kGooglePlex,
                              onMapCreated: (GoogleMapController controller) {

                                _controllerGoogleMap.complete(controller);
                                _controller = controller;
                                isMapCreated = true;
                                locatePosition();
                                getMapMode();
                                setState(() {});
                              },

                            ),

                            Positioned(
                              left: 10.0,
                              right: 10.0,
                              top: 14.0,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: 54.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 40.0,
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
                              left: 62.0,
                              right: 30.0,
                              top: 17.0,
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

                          //Bottom Tabs

                            Positioned(
                                left: 10.0,
                                right: 10.0,
                                bottom: 5.0,
                              child: Container(

                                padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                                height: 90.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 40.0,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 15.0,),
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
