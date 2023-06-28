// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../AppData/AppData.dart';

class How_to_use extends StatefulWidget {
  const How_to_use({Key? key}) : super(key: key);

  @override
  State<How_to_use> createState() => _How_to_useState();
}

class _How_to_useState extends State<How_to_use> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How To Use',style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Text('How To Use 1',style: GoogleFonts.poppins(fontSize: 20,color: textcolor),),
            ),
            Container(
              height: 250,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    textcolor,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0, 0.5],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/images/howToDownload.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Text('How To Use 2',style: GoogleFonts.poppins(fontSize: 20,color: textcolor),),
            ),
            Container(
              height: 250,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    textcolor,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0, 0.5],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/images/howToDownload.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Text('How To Use 3',style: GoogleFonts.poppins(fontSize: 20,color: textcolor),),
            ),
            Container(
              height: 250,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    textcolor,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0, 0.5],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/images/howToDownload.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 10),
              child: Text('How To Use 4',style: GoogleFonts.poppins(fontSize: 20,color: textcolor),),
            ),
            Container(
              height: 250,
              foregroundDecoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    textcolor,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0, 0.5],
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: const Image(
                image: AssetImage('assets/images/howToDownload.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
