import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hommie/bindings/bindings.dart';
import 'package:hommie/view/home.dart';
import 'package:hommie/view/startupscreen.dart';
import 'package:hommie/view/welcomescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _Myapp();
}

class _Myapp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: 'home',
      initialBinding: Binding(),
      routes: {
        '/': (context) => StartupScreen(),
        "home": (context) => Home(),
        "welcome": (context) => WelcomeScreen(),
      },
    );
  }
}
