import 'package:flutter/material.dart';
import 'package:cryptoshare_app/dashP.dart';
import 'package:cryptoshare_app/encP.dart';
import 'package:cryptoshare_app/decP.dart';
import 'package:cryptoshare_app/loginP.dart';
import 'package:cryptoshare_app/regP.dart';
import 'package:cryptoshare_app/editP.dart';

void main() {
  runApp(MaterialApp(
    // initialRoute: '/login',
    routes: {
      '/': (context) => LoginP(),
      '/dash': (context) => DashP(),
      '/enc': (context) => EncP(),
      '/dec': (context) => DecP(),
      '/login': (context) => LoginP(),
      '/reg': (context) => RegP(),
      '/edit': (context) => EditP(),
      // '/loading': (context) => LoadingP(),
    },
  ));
}