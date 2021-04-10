import 'package:geolocator/geolocator.dart';
import 'place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class GeoLocatorService{

  Future<Position> getLocation() async {
    var geolocator = Geolocator();
    return await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high, locationPermissionLevel: GeolocationPermission.location);
  }
}

class PlacesService {
  final key = 'AIzaSyDNBVxmJflnnUp9e9D3j16UMQBUkOlZbJI';

  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=17.3850,78.4867&type=parking&rankby=distance&key=AIzaSyDNBVxmJflnnUp9e9D3j16UMQBUkOlZbJI');
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }

}