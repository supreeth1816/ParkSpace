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

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,

      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Container(
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
                SizedBox(height: 60,),

            TextFormField(
              controller: emailController,
              // ignore: missing_return
              validator: (String value){
                if(value.isEmpty){
                  print("Empty value by user");
                }
              },

              decoration: InputDecoration(
                //   labelText: "First Name",
                  hintText: "Enter email",
                  hintStyle: TextStyle(
                    fontSize: 15,
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
                  focusedBorder:OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple.shade500, width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
            ),
                SizedBox(height: 10,),

                TextFormField(
                  controller: passwordController,
                  // ignore: missing_return
                  validator: (String value){
                    if(value.isEmpty){
                      print("Empty value by user");
                    }
                  },

                  decoration: InputDecoration(
                    //   labelText: "First Name",
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurple.shade500, width: 2.0),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                  ),
                ),
                SizedBox(height: 20,),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/user');
                  },
                  child: PrimaryButton(
                    btnText: "Login",
                  ),
                ),
                SizedBox(
                  height: 14,
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

