// ignore_for_file: file_names, unused_element, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingkart/Utils/imagePath.dart';

import '../Utils/colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.offAllNamed('/home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorSplashBG,
      body: Center(
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(150.0), // Adjust the radius as needed
              ),
              elevation: 4.0,
              child: SizedBox(
                width: 150,
                height: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      logo,
                      width: 75,
                      height: 75,
                    ),
                    const Text(
                      'Shopping Kart',
                      style: TextStyle(color: colorSplashtext, fontSize: 15),
                    )
                  ],
                ),
              ))),
    );
  }
}
