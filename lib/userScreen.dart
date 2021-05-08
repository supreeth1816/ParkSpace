import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/models/pindata.dart';
import 'package:geolocator/geolocator.dart';
import 'drawer.dart';
import 'package:flutter/services.dart';

class UserScreen extends StatefulWidget {

  @override
  _UserScreenState createState() => _UserScreenState();
}



class _UserScreenState extends State<UserScreen> {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  //initialising the controller for google map
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController _controller;

  Set<Marker> _markers = {

  };


  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }




  BitmapDescriptor mapMarker;

  void setCustomMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icon.png', 160);
    mapMarker = await BitmapDescriptor.fromBytes(markerIcon);
  }
  //
  // void setCustomMarker() async {
  //   mapMarker = await BitmapDescriptor.fromAssetImage(
  //       ImageConfiguration(), 'assets/icon.png');
  // }




  @override
  void initState() {

    setCustomMarker();
    super.initState();

  }



  String searchAddress;




  PinData _currentPinData = PinData(
      pinPath: '',
      avatarPath: '',
      location: LatLng(0, 0),
      locationName: '',
      labelColor: Colors.grey);

  PinData _sourcePinInfo;

  void _onMapCreated(GoogleMapController controller) {

  _controllerGoogleMap.complete(controller);
  _controller = controller;
  isMapCreated = true;
  locatePosition();
  getMapMode();
  _setMapPins();
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

  Widget _buildLocationInfo() {

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _currentPinData.locationName,
            ),
            Text(
              'Latitude : ${_currentPinData.location.latitude}',
            ),
            Text(
              'Longitude : ${_currentPinData.location.longitude}',
            )
          ],
        ),
      ),
    );
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


  //Method called when search button is clicked
  searchAndNavigate(){
      print(searchAddress);
      _controller.animateCamera(CameraUpdate.newCameraPosition(parkingLocation));
  }


  void _setMapPins() {
    _sourcePinInfo = PinData(
        pinPath: 'assets/icon.png',
        locationName: "My Location",


        location: LatLng(12.9717, 79.1594),
        avatarPath: "assets/icon.png",
        labelColor: Colors.blue);
  }




  @override
  Widget build(BuildContext context) {

    if (isMapCreated) {
      getMapMode();
    }
    return Scaffold(

      key: _scaffoldKey,

      appBar: AppBar(
          centerTitle: true,

          //AppBar Title
          title: Text("ParkSpace", style: TextStyle(color: Colors.deepPurple),),
          backgroundColor: Colors.white,

          //Hamburger Menu icon
          leading: IconButton(
            icon: Icon(Icons.menu),
            color: Colors.deepPurple,
            onPressed: () => _scaffoldKey.currentState.openDrawer(),

          ),

          shadowColor: Colors.white,
          elevation: 0,

        ),

        drawer: MyDrawer(),

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
                              onMapCreated: _onMapCreated,
                              markers: _markers,
                              initialCameraPosition: parkingLocation,
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
                                  children: <Widget>[
                                    _buildLocationInfo(),
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

