import 'package:flutter/material.dart';
import 'package:cryptoshare_app/allGlobal.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

class DecP extends StatefulWidget {
  @override
  _DecPState createState() => _DecPState();
}

class _DecPState extends State<DecP> {
  TextEditingController ky = TextEditingController();
  TextEditingController txxt = TextEditingController();

  bool flag=true;
  var dc_txt = "";

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
              color: Color(0xffededf7)
          ),
          elevation: 24,
          title: Text(
            "CryptoShare",
            style: GoogleFonts.pressStart2p(
              fontSize: 12,
              // fontFamily: 'Wind',
              color: Color(0xffededf7),
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
                Color(0xffededf7),
                Color(0xffededf7),
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
                Text(
                  "Decrypt",
                  style: TextStyle(
                    fontSize: 48,
                    fontFamily: 'Nexa',
                    color: Color(0xff7466c1),
                  ),
                ),
                SizedBox(height: 50,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextField(
                      controller: ky,
                      // maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xff7466c1),
                        filled: true,
                        hintText: 'Public key of sender',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Color(0x99ededf7),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Color(0xffededf7),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextField(
                      controller: txxt,
                      // maxLength: 10,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        fillColor: Color(0xff7466c1),
                        filled: true,
                        hintText: 'Code',
                        hintStyle: TextStyle(
                          fontSize: 22,
                          fontFamily: 'Nexa',
                          color: Color(0x99ededf7),
                        ),
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.go,
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Righteous',
                        color: Color(0xffededf7),
                      ),
                    ),
                    SizedBox(height: 20,),
                    SizedBox(height: 20,),
                    RaisedButton(
                      onPressed: () async{
                        if(ky.text.length>0 && txxt.text.length>0) {

                          dc_txt = await decryptAESCryptoJS(txxt.text, secret_key(int.parse(ky.text),priv_key).toString());
                          print("derypted");
                          print(dc_txt);
                          // await Share.share("Message: "+en_txt);

                          return showDialog(context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Decrypted Message",
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                    color: Color(0xffededf7),
                                    fontFamily: 'Nexa',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  content: Text(
                                    dc_txt,
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontFamily: 'Nexa',
                                      color: Color(0xffededf7),
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                          color: Color(0xffededf7),
                                          fontFamily: 'Nexa',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      splashColor: Color(0xffededf7),
                                    )
                                  ],
                                  backgroundColor: Color(0xff7466c1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                );
                              }
                          );

                          // Navigator.pop(context);
                        }
                        else {
                          flag=true;
                          return showDialog(context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    "Invalid input!",
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                    color: Color(0xffededf7),
                                    fontFamily: 'Nexa',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  content: Icon(
                                    Icons.warning_amber_outlined,
                                    size: 72,
                                    color: Color(0xffededf7),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Close',
                                        style: TextStyle(
                                          color: Color(0xffededf7),
                                          fontFamily: 'Nexa',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      splashColor: Color(0xffededf7),
                                    )
                                  ],
                                  backgroundColor: Color(0xff7466c1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                );
                              }
                          );
                        }
                      },
                      child: Text(
                        "Decrypt",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Nexa',
                          color: Color(0xffededf7),
                        ),
                      ),
                      elevation: 24,
                      padding: EdgeInsets.fromLTRB(45, 14, 45, 13),
                      color: Color(0xff7466c1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}