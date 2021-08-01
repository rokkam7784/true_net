import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:true_net/Constants/Colors.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Kclr01,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 15,
          ),
          Expanded(child: Image.asset("images/TrueNet-noBg.png")),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          backgroundColor: Kclr22,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/71757457?s=400&u=bae5c14bfbdf0b0e90a0aad5a13fe47cb0edec9f&v=4"),
                          radius: 50,
                        ),
                      ),
                      // margin: EdgeInsets.symmetric(horizontal: 30),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "R. Vinayak",
                          //TODO styling Logout text

                          style: GoogleFonts.libreBaskerville(
                            // wordSpacing: 1,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Kclr21,
                          ),
                        ),
                        Text(
                          "Main TrueNet Developer",
                          //TODO styling Logout text
                          style: GoogleFonts.libreBaskerville(
                            // wordSpacing: 1,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Kclr21,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Text(
                //   "R. Vinayak",
                //   //TODO styling Logout text
                //
                //   style: GoogleFonts.libreBaskerville(
                //     // wordSpacing: 1,
                //     letterSpacing: 1,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 30,
                //     color: Kclr21,
                //   ),
                // ),
                // Text(
                //   "Main TrueNet Developer",
                //   //TODO styling Logout text
                //   style: GoogleFonts.libreBaskerville(
                //     // wordSpacing: 1,
                //     letterSpacing: 1,
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20,
                //     color: Kclr21,
                //   ),
                // ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "TrueNet is a simple Flutter Firebase messaging app made to get the better understanding of concepts and hence still may have few bugs.",
                    //TODO styling Logout text
                    textAlign: TextAlign.center,
                    style: GoogleFonts.libreBaskerville(
                      // wordSpacing: 1,
                      letterSpacing: 1,
                      // fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Kclr21,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    "Stay Connected Truly with TrueNet",
                    //TODO styling Logout text
                    textAlign: TextAlign.center,
                    style: GoogleFonts.libreBaskerville(
                      // wordSpacing: 1,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Kclr21,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
