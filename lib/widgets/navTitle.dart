import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:
      RichText(
        text: TextSpan(
            text: 'Park',
            style: GoogleFonts.quicksand(

            textStyle: TextStyle(
                color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.w800),

            ),
            children: <TextSpan>[
        TextSpan(
        text: 'Space',
            style: GoogleFonts.quicksand(

              textStyle: TextStyle(
                  color: Colors.deepPurple, fontSize: 18, fontWeight: FontWeight.w500),
            ),
        ),
        ],
      ),
    ),
    );
  }
}


