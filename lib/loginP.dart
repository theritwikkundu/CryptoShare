import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cryptoshare_app/allGlobal.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginP extends StatelessWidget {

  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();

  bool loginFlag=false;
  Future<void> credValid(String ids, String pws) async
  {
    final DBRef = await FirebaseDatabase.instance.reference();
    await DBRef.child("regn").once().then((DataSnapshot dataSnapShot){
      var newdata = dataSnapShot.value;
      newdata.forEach((key,values){
        print(values['phone']);
        if((values['phone'])==ids && (values['pass'])==pws){
          currentPh = values['phone'];
          currentName = values['name'];
          currentPass = values['pass'];
          priv_key = int.parse(values['priv']);
          pub_key = gen_key(priv_key);

          loginFlag=true;
        }
      });
      id.clear();pw.clear();
    });
    await updateSaved();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              mrkColLit,
              mrkColLit,
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
              SizedBox(height: 120,),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Crypto",
                        style: GoogleFonts.pressStart2p(
                          fontSize: 36,
                          // fontFamily: 'Wind',
                          color: mrkColDrk,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Share",
                        style: GoogleFonts.pressStart2p(
                          fontSize: 36,
                          // fontFamily: 'Wind',
                          color: mrkColDrk,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  TextField(
                    controller: id,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColWhtT,
                      filled: true,
                      hintText: 'Phone',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: Color(0x997466c1),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                    cursorColor: mrkColDrk,
                  ),
                  SizedBox(height: 5,),
                  TextField(
                    controller: pw,
                    maxLength: 20,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColWhtT,
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: Color(0x997466c1),
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                    obscureText: true,
                    cursorColor: mrkColDrk,
                  ),
                  // SizedBox(height: 8,),
                  SizedBox(height: 48,),
                  RaisedButton(
                    onPressed: () async {
                      await credValid(id.text, pw.text);
                      if(loginFlag)
                        Navigator.pushReplacementNamed(context, '/dash');
                      else
                        return showDialog(context: context, barrierDismissible: false, builder: (context){
                          return AlertDialog(
                            title: Text(
                              "Invalid Credentials!",
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                              color: mrkColDrk,
                              fontFamily: 'Nexa',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                    color: mrkColDrk,
                                    fontFamily: 'Nexa',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                splashColor: mrkColDrk,
                              )
                            ],
                            backgroundColor: mrkColLit,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          );
                        });
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 28,
                        fontFamily: 'Nexa',
                        color: mrkColWht,
                      ),
                    ),
                    elevation: 24,
                    padding: EdgeInsets.fromLTRB(32, 12, 32, 12),
                    color: mrkColDrk,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 0,),
              SizedBox(height: 60,),
              FlatButton(
                  onPressed: (){Navigator.pushNamed(context, '/reg');},
                  child: Text(
                      "Register",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Nexa',
                        color: mrkColDrk,
                      )
                  )
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     dbclass.writeRegData("Sayam", "2222", "7894561230", "pass");
      //   },
      // ),
    );
  }
}
