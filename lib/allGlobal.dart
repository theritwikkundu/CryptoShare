import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_database/firebase_database.dart';

int priv_key = 9999;
int pub_key = gen_key(priv_key);

String currentPh="default phone";
String currentName="default name";
String currentPass="default pass";
// String currentPriv="default pass";

Color mrkColDrk = Color(0xff7466c1);
Color mrkColDrkT = Color(0xff7466c1);
Color mrkColLit = Color(0xffebebf4);
Color mrkColWht = Color(0xffffffff);
Color mrkColWhtT = Color(0xffffffff);


//generating a public key
int gen_key(a) {
  int n = 23456; //prime = fixed for the app
  int g = 10; //generator = fixed for the app
  int x = (g^a)%n;
  return x;
}

//generating a secret key
int secret_key(x,a) {
  int n = 23456; //prime = fixed for the app
  int k = (x^a)%n;
  return k;
}

String encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    throw error;
  }
}

String decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    Uint8List encryptedBytes =
    encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
    encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (error) {
    throw error;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(
          currentHash + password + salt);
    else
      preHash = Uint8List.fromList(
          password + salt);

    // currentHash = md5.convert(preHash).bytes;
    currentHash = Uint8List.fromList(md5.convert(preHash).bytes); //jugaad
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBtyes = concatenatedHashes.sublist(0, 32);
  var ivBtyes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i=0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax)+1;
  }
  return uint8list;
}

// local save

Future<void> loadSaved(BuildContext context) async {
  final mrkSaved = await SharedPreferences.getInstance();
  priv_key = await int.parse((mrkSaved.getString('priv')??priv_key).toString());
  pub_key = gen_key(priv_key);
  print("loaded saved");
}

Future<void> updateSaved() async {
  final mrkSaved = await SharedPreferences.getInstance();
  await mrkSaved.setString('priv',priv_key.toString());
  print("updated saved");
}

Future<void> clearSavedLocal() async {
  priv_key = 9999;
  pub_key = gen_key(priv_key);
  print("cleared locally saved");
}


// database

class dbclass {

  static bool readData(String phn) {
// database reference string
    final DBRef = FirebaseDatabase.instance.reference();
    bool fl = false;
    print("Phone: " + phn);
    DBRef.child("regn").once().then((DataSnapshot dataSnapShot) {
      var newdata = dataSnapShot.value;
// var key = newdata.keys.elementAt("1234");
      newdata.forEach((key, values) {
        print(values['phone']);
        if ((values['phone']) == phn) {
          fl = true;
        }
      });
      return fl;
    });
    return fl;
  }

  // static void writeRegData(String name, String priv, String phone, String password) { //todo
  static Future<void> writeRegData(String name, String priv, String phone, String password) async {
// database reference string
    final DBRef = await FirebaseDatabase.instance.reference();
    await DBRef.child("regn").child(phone).set({
      'phone': phone,
      'name': name,
      'priv': priv,
      'pass': password
    });
    print("data created");
  }

  static void updateRegData(String name, String priv, String phone,
      String password) {
    final DBRef = FirebaseDatabase.instance.reference();
    DBRef.child("regn").child(phone).update({
      'name': name,
      'priv': priv,
      'pass': password
    });
    print("data updated");
  }

  static void deleteAccData(String phone){
    final DBRef = FirebaseDatabase.instance.reference();
    DBRef.child("regn").child(phone).remove();
    print("data deleted");
  }
}