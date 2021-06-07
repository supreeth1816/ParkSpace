import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:parkspace/widgets/drawer.dart';
import 'package:parkspace/widgets/primaryButton.dart';

class VendorScreen extends StatefulWidget {
  @override
  _VendorScreenState createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {


  String _slotName, _slotDescription, _slotPrice;
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  //TextEditingController descController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      drawer: MyDrawer(),

      appBar: AppBar(


        centerTitle: true,

        //AppBar Title
        title: Text("Parking Vendor", style: GoogleFonts.quicksand(color: Colors.deepPurple, fontWeight: FontWeight.w800, fontSize: 18), ),
        backgroundColor: Colors.white,

        //Hamburger Menu icon
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.deepPurple,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),

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
      body: Center(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(



            children: [


              SizedBox(height: 40,),


              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.emailAddress,
                // ignore: missing_return
                validator: (String value){
                  if(value.isEmpty){
                    print("Empty value by user");
                  }
                },
                onChanged: (value){
                  setState(() {
                    _slotName = value;
                  });
                },

                decoration: InputDecoration(
                  //   labelText: "First Name",
                    hintText: "Enter Slot Name",
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




              Container(
                height: 186,

               // width: double.infinity,
                margin: EdgeInsets.only(left: 0, right: 0),

                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.black38, width: 1),
                  borderRadius: BorderRadius.circular(15),

                ),
                padding: EdgeInsets.all(20),

                child: TextField(
                  maxLines: 6,
                  decoration: InputDecoration.collapsed(
                      hintText: "Enter Slot Description ", hintStyle: TextStyle(
                    fontSize: 16,
                  )),
                  style: GoogleFonts.poppins(
                      fontSize: 17,
                      color: Color(0xff3a3a3a)
                  ),

                  onChanged: (val){
                    setState(() {
                      _slotDescription = val;
                    });
                  },
                ),
              ),
              SizedBox(height: 20,),



              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/selectlocation'),
                child: Container(
                  child: Row(
                    //  crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 10,),
                      Icon(Icons.location_on, color: Colors.deepPurple,),
                      SizedBox(width: 10,),

                      Text("Select Location", style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 200,),

              GestureDetector(

                onTap: () {
                  Navigator.pushNamed(context, '/user');
                },
                child: PrimaryButton(
                  btnText: "Add Parking Slot",
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
