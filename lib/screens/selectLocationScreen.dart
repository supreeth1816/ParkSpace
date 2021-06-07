import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  List<Marker> myMarkers = [];

  _handleTap(LatLng tappedPoint){
    
  }



  final CameraPosition parkingLocation = CameraPosition(
    target: LatLng(12.9717, 79.1594),
    zoom: 16.4746,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: parkingLocation,
          markers: Set.from(myMarkers),


        ),
      ),
    );
  }
}
