import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  final name = 'Supreeth';
  final email = 'supreet.venkata@gmail.com';
  final urlImage =
      'https://media-exp1.licdn.com/dms/image/C5603AQEpW-HYtoueUQ/profile-displayphoto-shrink_400_400/0/1620761746684?e=1626912000&v=beta&t=p1ViNjbgGYGWpZtYVuqzdjEMZ8xRNPEcMRd2XPH3hmQ';

  Widget buildHeader({
    @required String urlImage,
    @required String name,
    @required String email,
    @required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),

            ],
          ),
        ),
      );

  Widget buildSearchField() {


    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/user'),
      child: Container(
        padding: EdgeInsets.only(left: 70,right: 70, top: 15,bottom: 15),

        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
          border: Border.all(color: Colors.white, width: 1),
        ),

        child: Text(
          "Find parking slot",


          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0

          ),
        ),

      ),
    );
  }





  Widget buildMenuItem({
    @required String text,
    @required IconData icon,
    VoidCallback onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {

      //post parking
      case 0:
        Navigator.pushNamed(context, '/vendor');
        break;

       //parking status
      case 1:
        Navigator.pushNamed(context, '/status');
        break;


    }
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Color(0xff823dc9),
        child: ListView(
          children: <Widget>[
            buildHeader(
              urlImage: urlImage,
              name: name,
              email: email,
              onClicked: () => Navigator.pushNamed(context, '/user'),
            ),
            Container(

              child: Column(
                children: [
                  const SizedBox(height: 12),
                  buildSearchField(),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Post parking slot',
                    icon: Icons.location_on_outlined,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Parking status',
                    icon: Icons.timeline,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'History',
                    icon: Icons.history,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Payments',
                    icon: Icons.payment,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Settings',
                    icon: Icons.settings,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
