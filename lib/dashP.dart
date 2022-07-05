import 'package:cryptoshare_app/allGlobal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class DashP extends StatefulWidget {
  @override
  _DashPState createState() => _DashPState();
}

class _DashPState extends State<DashP> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Color(0xededf7ff)
          ),
          elevation: 24,
          title: Text(
            "CryptoShare",
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              // fontFamily: ,
              color: Color(0xededf7ff),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xff7466c1),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          alignment: Alignment.topCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xededf7ff),
                Color(0xededf7ff),
                // Color(0xffC8D5B9),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60,),
                    Column(
                      children: [
                        Text(
                          "PUBLIC KEY",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Nexa',
                            color: Color(0xff7466c1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8,),
                        Text(
                          pub_key.toString(),
                          style: TextStyle(
                            fontSize: 42,
                            fontFamily: 'Nexa',
                            color: Color(0xff7466c1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12,),
                        RaisedButton(
                          onPressed: () async {
                            await Share.share("Hey there! Send me encrypted messages using CryptoShare with my public key "+pub_key.toString());
                          },
                          child: Icon(
                            Icons.share,
                            color: Color(0xffebebf4),
                            size: 32,
                          ),
                          elevation: 24,
                          padding: EdgeInsets.fromLTRB(2, 10, 2, 10),
                          color: Color(0x697466c1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 60,),
                    RaisedButton(
                      onPressed: () async{Navigator.pushNamed(context, '/enc');},
                      child: Text(
                        "Encrypt",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Nexa',
                          color: Color(0xededf7ff),
                        ),
                      ),
                      elevation: 24,
                      padding: EdgeInsets.fromLTRB(45, 14, 45, 13),
                      color: Color(0xff7466c1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    SizedBox(height: 40,),
                    RaisedButton(
                      onPressed: () async{Navigator.pushNamed(context, '/dec');},
                      child: Text(
                        "Decrypt",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Nexa',
                          color: Color(0xededf7ff),
                        ),
                      ),
                      elevation: 24,
                      padding: EdgeInsets.fromLTRB(45, 14, 45, 13),
                      color: Color(0xff7466c1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 0,),
              ],
            ),
          ),
        ),

        drawer: Container(
          width: 200,
          padding: EdgeInsets.fromLTRB(10, 42, 10, 36),
          alignment: Alignment.topCenter,
          color: mrkColDrk,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person_pin,
                      size: 108,
                      color: mrkColWht,
                    ),
                    radius: 56,
                    backgroundColor: Color(0x00000000),
                  ),
                  SizedBox(height: 20,),
                  SizedBox(
                    width: 170,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Nexa',
                            color: mrkColWht,
                            // fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          currentName,
                          style: TextStyle(
                              fontSize: 24,
                              fontFamily: 'Nexa',
                              color: mrkColWht,
                              fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(height: 30,),
                        OutlineButton(
                          onPressed: (){Navigator.pushNamed(context, '/edit');},
                          child: SizedBox(
                            width: 140,
                            child: Text(
                              "My info",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Nexa',
                                color: mrkColWht,
                                // fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: mrkColWht,
                            width: 1,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  FlatButton(
                    onPressed: () async {
                      await clearSavedLocal();
                      await updateSaved();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: SizedBox(
                      width: 140,
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Nexa',
                            color: mrkColDrk,
                            fontWeight: FontWeight.w600
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    color: mrkColWht,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}