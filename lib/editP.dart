import 'package:flutter/material.dart';
import 'package:cryptoshare_app/allGlobal.dart';
import 'dart:math';

class EditP extends StatefulWidget {

  @override
  _EditPState createState() => _EditPState();
}

class _EditPState extends State<EditP> {

  TextEditingController nm = TextEditingController();
  TextEditingController priv = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();

  bool credValid(String psw, String psw2)
  {
    if (psw.length>=4 && psw==psw2)
    {
      // ph.clear();
      // pw.clear();
      return true;
    }
    else
    {
      pw.clear();
      pw2.clear();
      return false;
    }
  }

  void updtAc(){
    dbclass.updateRegData(nm.text, priv.text, currentPh, pw.text);
    print("Updating account");
  }

  Future<void> dltAc() async {
    dbclass.deleteAccData(currentPh);
    print("Deleted account");
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/login');
  }

  void insertText(String insert, TextEditingController controller) {
    final int cursorPos = controller.selection.base.offset;
    controller.value = controller.value.copyWith(
        text: controller.text.replaceRange(max(cursorPos, 0), max(cursorPos, 0), insert),
        selection: TextSelection.fromPosition(TextPosition(offset: max(cursorPos, 0) + insert.length))
    );
  }

  @override
  void initState() {
    super.initState();
    insertText(currentName, nm);
    insertText(priv_key.toString(), priv);
    // insertText("SoftwareEngineering", pw);
    // insertText("SoftwareEngineering", pw2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 24,
        title: Text(
          "CoviWise",
          style: TextStyle(
            fontSize: 28,
            fontFamily: 'Wind',
            color: mrkColDrk,
          ),
        ),
        centerTitle: true,
        backgroundColor: mrkColLit,
        iconTheme: IconThemeData(color: mrkColDrk),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              mrkColDrk,
              mrkColDrk,
              // mrkColMed,
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
              SizedBox(height: 10,),
              Text(
                "Edit info",
                style: TextStyle(
                  fontSize: 56,
                  fontFamily: 'Wind',
                  color: mrkColLit,
                ),
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    cursorColor: mrkColDrkT,
                    controller: nm,
                    // maxLength: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColLit,
                      filled: true,
                      hintText: 'Name',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: mrkColDrkT,
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextField(
                    cursorColor: mrkColDrkT,
                    controller: priv,
                    maxLength: 10,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColLit,
                      filled: true,
                      hintText: 'Private key',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: mrkColDrkT,
                      ),
                    ),
                    keyboardType: TextInputType.datetime,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                  ),
                  TextField(
                    cursorColor: mrkColDrkT,
                    obscureText: true,
                    controller: pw,
                    maxLength: 20,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColLit,
                      filled: true,
                      hintText: 'New password',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: mrkColDrkT,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                  ),
                  TextField(
                    cursorColor: mrkColDrkT,
                    obscureText: true,
                    controller: pw2,
                    maxLength: 20,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      fillColor: mrkColLit,
                      filled: true,
                      hintText: 'Confirm password',
                      hintStyle: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Nexa',
                        color: mrkColDrkT,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Nexa',
                      color: mrkColDrk,
                    ),
                  ),
                  SizedBox(height: 12,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlineButton(
                    onPressed: () async {
                      return showDialog(context: context, barrierDismissible: false, builder: (context){
                        return AlertDialog(
                          title: Text(
                            "Are you sure you want to delete your account?",
                            textAlign: TextAlign.center,
                          ),
                          titleTextStyle: TextStyle(
                            color: mrkColDrk,
                            fontFamily: 'Nexa',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          content: Icon(
                            Icons.delete_outline,
                            size: 72,
                            color: mrkColDrk,
                          ),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: mrkColDrk,
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  splashColor: mrkColDrk,
                                ),
                                MaterialButton(
                                  onPressed: () async {
                                    await dltAc();
                                    await clearSavedLocal();
                                    await updateSaved();
                                    // Navigator.of(context).pop();
                                    return showDialog(context: context, barrierDismissible: false, builder: (context){
                                      return AlertDialog(
                                        title: Text(
                                          "Accound deleted!",
                                          textAlign: TextAlign.center,
                                        ),
                                        titleTextStyle: TextStyle(
                                          color: mrkColDrk,
                                          fontFamily: 'Nexa',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        content: Icon(
                                          Icons.delete_sweep_outlined,
                                          size: 72,
                                          color: mrkColDrk,
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
                                    'Confirm',
                                    style: TextStyle(
                                      color: mrkColDrk,
                                      fontFamily: 'Nexa',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  splashColor: mrkColDrk,
                                ),
                              ],
                            ),
                          ],
                          backgroundColor: mrkColLit,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        );
                      }
                      );
                    },
                    child: Text(
                      "Delete",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Nexa',
                        color: mrkColLit,
                      ),
                    ),
                    // elevation: 24,
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    // color: mrkColLit,
                    borderSide: BorderSide(
                      color: mrkColLit,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      if(credValid(pw.text, pw2.text)) {
                        updtAc();
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(context, '/login');
                        return showDialog(context: context, barrierDismissible: false, builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Personal info updated successfully!",
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                              color: mrkColDrk,
                              fontFamily: 'Nexa',
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            content: Icon(
                              Icons.done_outline_rounded,
                              size: 72,
                              color: mrkColDrk,
                            ),
                            actions: [
                              MaterialButton(
                                onPressed: () {
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
                              ),
                            ],
                            backgroundColor: mrkColLit,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16)),
                          );
                        }
                        );
                      }
                      else
                      {
                        return showDialog(context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Failed!",
                                  textAlign: TextAlign.center,
                                ),
                                titleTextStyle: TextStyle(
                                  color: mrkColDrk,
                                  fontFamily: 'Nexa',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                content: Text(
                                  "Please check the following and try again:\n\n1.\t\tIf you have a stable internet connection.\n2.\tThe entered passwords match.\n3.\tThe password has at least 4 charachters.",
                                  style: TextStyle(
                                    fontFamily: 'Nexa',
                                    fontSize: 16,
                                    color: mrkColDrk,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                actions: [
                                  MaterialButton(
                                    onPressed: () {
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
                                  ),
                                ],
                                backgroundColor: mrkColLit,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16)),
                              );
                            }
                        );
                      }
                    },
                    child: Text(
                      "Update",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Nexa',
                        color: mrkColDrk,
                      ),
                    ),
                    // elevation: 24,
                    padding: EdgeInsets.fromLTRB(20, 12, 20, 12),
                    color: mrkColLit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
