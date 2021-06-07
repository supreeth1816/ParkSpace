
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parkspace/widgets/marker.dart';

List<Marker> myMarkers = [
  Marker(
    markerId: MarkerId("parking - 1"),
    position: LatLng(12.9717, 79.1594),
    icon: mapMarker,
    infoWindow: InfoWindow(
        title: "Alex's Parking Space",
        snippet: "Rs 216.06/hr"
    ),
  )

];