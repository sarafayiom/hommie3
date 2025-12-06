
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Get.put(StartupScreen());
    return Scaffold(backgroundColor:Colors.white,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "assets/images/logopage.png"), 
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}