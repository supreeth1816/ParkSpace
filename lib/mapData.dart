import 'dart:async';
import 'package:parkspace/widgets/marker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';
import 'package:parkspace/screens/userScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/markerData.dart';

Set<Marker> _markers = {

};

GoogleMapController _controller;

//default location
final LatLng myLocation = LatLng(12.9717, 79.1594);
//zoom for the default location
final CameraPosition parkingLocation = CameraPosition(
  target: myLocation,
  zoom: 16.4746,
);

class MapData extends StatefulWidget {
  @override
  _MapDataState createState() => _MapDataState();
}

class _MapDataState extends State<MapData> {

  Completer<GoogleMapController> _controllerGoogleMap = Completer();


// Using set becauase all points are unique

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
                title: "Alex's Parking Space",
                snippet: "Rs 216.06/hr"
            ),
          )
      );
    });
  }




  Position currentPosition;
  var geoLocator = Geolocator();

  bool isMapCreated = false;

  //Setting Map Style
  getMapMode() {
    getJsonFile("assets/map_style.json").then(setMapStyle);
  }

  //Get json file from path
  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    _controller.setMapStyle(mapStyle);
  }

  void locatePosition() async
  {

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    currentPosition = position;
    LatLng myPos = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition = CameraPosition(
        target: myPos,
        zoom: 16.4746);

    _controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {

    if (isMapCreated) {
      getMapMode();
    }

    return GoogleMap(
      trafficEnabled: true,
      mapType: MapType.normal,
      zoomControlsEnabled: true,
      myLocationButtonEnabled: false,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: _onMapCreated,


      //  markers: Set<Marker>.of(myMarkers.values),
      markers: Set.from(myMarkers),
      initialCameraPosition: parkingLocation,
    );
  }
}

searchAndNavigate(){
   print(searchAddress);
  _controller.animateCamera(CameraUpdate.newCameraPosition(parkingLocation));

  //print(myMarkers);
  FirebaseFirestore.instance
      .collection('test')
      .add({'text': 'data added through app'});
}

getAllMarkers(){
  print("markers: ");
  print(_markers);
  //  containerHeight = 200.0;
}
