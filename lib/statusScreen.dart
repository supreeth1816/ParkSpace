import 'package:flutter/material.dart';
import 'drawer.dart';
import 'drawer.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {



  final TextStyle whiteNameTextStyle = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontWeight: FontWeight.w600,
  );
  final TextStyle whiteSubHeadingTextStyle = TextStyle(
    fontSize: 18.0,
    color: Colors.white,
    fontWeight: FontWeight.w400,
  );

  final TextStyle actionMenuStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.black87,
    fontWeight: FontWeight.w600,
    letterSpacing: 5,
  );

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      key: _scaffoldKey,
      drawer: MyDrawer(),

      appBar: AppBar(


        centerTitle: true,

        //AppBar Title
        title: Text("ParkSpace", style: TextStyle(color: Colors.deepPurple),),
        backgroundColor: Colors.white,

        //Hamburger Menu icon
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.deepPurple,
          onPressed: () => _scaffoldKey.currentState.openDrawer(),

        ),

        shadowColor: Colors.white,
        elevation: 0,

      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "Find Parking Status",
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.1,
                ),
              ),
            ),

            Card(
              elevation: 8,
              shadowColor: Colors.black45,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.search),
                      hintText: "Search",
                      hintStyle: whiteSubHeadingTextStyle.copyWith(color: Colors.black87)),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Refresh",
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold

                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Icon(
                      Icons.refresh,
                    ),
                    Spacer(),
                    // Text(
                    //   "1h",
                    //   style: subTitleStyle.copyWith(color: Colors.black),
                    // ),
                  ],
                )),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Card(
                        elevation: 0,

                        shadowColor: Colors.white54,

                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(top: 10, bottom: 10),

                          title: Container(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              "Parking Slot 1",
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          subtitle: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.location_on_outlined,
                                color: Colors.black38,
                              ),
                              Text(
                                "  Vellore",
                                style: whiteSubHeadingTextStyle.copyWith(color: Colors.black38, fontSize: 14),
                              ),
                            ],
                          ),
                          leading: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: ClipOval(
                              child: Image.asset(
                                "assets/icon.png",
                                width: 60,
                                height: 50,
                              ),
                            ),
                          ),
                          trailing: SizedBox(
                            width: 106,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 12,
                                        height: 12,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,

                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Slot Filled",
                                        style: whiteSubHeadingTextStyle.copyWith(color: Colors.green, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [

                                      Text(
                                        "₹ 106.20"
                                      ),
                                      SizedBox(width: 10,),
                                      Icon(
                                        Icons.push_pin,
                                        color: Colors.blueAccent,
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                       height: 1.0,
                        width: 340,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  );
                },
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
