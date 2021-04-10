import 'package:flutter/material.dart';
import 'ParkingVendorScreen.dart';
import 'UserScreen.dart';
import 'package:geolocator/geolocator.dart';
import 'place.dart';
import 'services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(

      ParkspaceApp());

}

class ParkspaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => GeoLocatorService().getLocation()),
        ProxyProvider<Position,Future<List<Place>>>(
          update: (context,position,places){
            return (position !=null) ? PlacesService().getPlaces(position.latitude, position.longitude) :null;
          },
        )
      ],


      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        home: StartScreen(),

        routes: {

          '/vendor': (context) => ParkingVendorScreen(),
          '/user': (context) => UserScreen(),
        },
      ),
    );
  }
}


class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: Container(
        padding: EdgeInsets.fromLTRB(40, 100, 40, 0),


        child: Column(


          children: [

            Image.asset('assets/Logo.png',
              width: 280,

            ),

            Text("ParkSpace",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black87
              ),
            ),
            SizedBox(height: 5,),
            Text("Smart Parking Application",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
              ),
            ),
            SizedBox(height: 150,),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/user');
              },
              child: PrimaryButton(
                btnText: "Login as User",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/vendor');
                },
              child: OutlineBtn(
                btnText: "Login as Vendor",
              ),
            )
          ],
        ),
      ),
    );
  }
}



class PrimaryButton extends StatefulWidget {
  final String btnText;
  PrimaryButton({this.btnText});

  @override
  _PrimaryButtonState createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

class OutlineBtn extends StatefulWidget {
  final String btnText;
  OutlineBtn({this.btnText});

  @override
  _OutlineBtnState createState() => _OutlineBtnState();
}

class _OutlineBtnState extends State<OutlineBtn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.deepPurple,
              width: 2
          ),
          borderRadius: BorderRadius.circular(23)
      ),
      padding: EdgeInsets.all(20),
      child: Center(
        child: Text(
          widget.btnText,
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 16
          ),
        ),
      ),
    );
  }
}

