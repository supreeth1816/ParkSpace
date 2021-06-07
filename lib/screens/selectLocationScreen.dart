import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/widgets/marker.dart';


class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {

  List<Marker> myMarkers = [];

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);

    setState(() {
      myMarkers = [];
      myMarkers.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          icon: mapMarker,


        ),

      );

    });

    
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

          onTap: _handleTap,


        ),
      ),
    );
  }
}
