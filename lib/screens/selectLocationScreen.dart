import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/widgets/marker.dart';
import 'package:parkspace/models/markerData.dart';


LatLng selectedPoint;

GoogleMapController _controller;

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {




  _handleTap(LatLng tappedPoint){

    selectedPoint = tappedPoint;
    print("Selected Point = ($selectedPoint)");

    setState(() {
     // myMarkers = [];
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

      appBar: AppBar(


      centerTitle: true,

      //AppBar Title
      title: Text("Add Parking Slot", style: GoogleFonts.quicksand(color: Colors.deepPurple, fontWeight: FontWeight.w800, fontSize: 18), ),
      backgroundColor: Colors.white,

      //Hamburger Menu icon
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_outlined),
        color: Colors.deepPurple,
        onPressed: () => Navigator.pushNamed(context, '/vendor'),

      ),

      shadowColor: Colors.white,
      elevation: 0,

      actions: <Widget>[
        // IconButton(
        //   splashColor: Colors.transparent,
        //   highlightColor: Colors.transparent,
        //   icon: Icon(
        //     Icons.refresh,
        //     size: 20,
        //     color: Colors.deepPurple,
        //   ),
        //   onPressed: _updateDataSource,
        // ),
      ],

    ),

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
