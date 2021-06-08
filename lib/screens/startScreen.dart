import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:parkspace/widgets/primaryButton.dart';


class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  String _email, _password;
  final auth = FirebaseAuth.instance;


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
                  keyboardType: TextInputType.emailAddress,
                  // ignore: missing_return
                  validator: (String value){
                    if(value.isEmpty){
                      print("Empty value by user");
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      _email = value.trim();
                    });
                  },

                  decoration: InputDecoration(
                    //   labelText: "First Name",
                      hintText: "Enter email",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
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
                  obscureText: true,
                  // ignore: missing_return
                  validator: (String value){
                    if(value.isEmpty){
                      print("Empty value by user");
                    }
                  },
                  onChanged: (value){
                    setState(() {
                      _password = value.trim();
                    });
                   },

                  decoration: InputDecoration(
                    //   labelText: "First Name",
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        fontSize: 15,
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(14, 0, 10, 0),
                      focusedBorder:OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
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

                    auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.pushNamed(context, '/user');
                    });

                    },
                  child: PrimaryButton(
                    btnText: "Login",
                  ),
                ),

                SizedBox(
                  height: 14,
                ),

                Container(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                                color: Colors.black, fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(text: '  SIGN UP',
                                  style: TextStyle(
                                      color: Colors.deepPurple, fontSize: 16,
                                    fontWeight: FontWeight.bold

                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      // navigate to desired screen
                                      auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                                        Navigator.pushNamed(context, '/user');
                                      });
                                    }
                              )
                            ]
                        ),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



