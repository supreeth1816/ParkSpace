import 'package:flutter/material.dart';
import 'ParkingVendorScreen.dart';
import 'UserScreen.dart';

void main() {
  runApp(
      ParkspaceApp());

}

class ParkspaceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(

        debugShowCheckedModeBanner: false,
        home: StartScreen(),

        routes: {

          '/vendor': (context) => ParkingVendorScreen(),
          '/user': (context) => UserScreen(),
        },
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
                fontSize: 26,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
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
                btnText: "Login",
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
                btnText: "Sign Up",
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
          borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(15),
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
          borderRadius: BorderRadius.circular(15)
      ),
      padding: EdgeInsets.all(15),
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

