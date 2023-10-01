// ignore_for_file: file_names, unused_element, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:io';

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
  // bool
  bool ActiveConnection = false;

  @override
  void initState() {
    super.initState();

    initialize();
  }

  Future initialize() async {
    await CheckUserConnection();

    ActiveConnection
        ? Future.delayed(
            const Duration(seconds: 3),
            () {
              Get.offAllNamed('/home');
            },
          )
        : NoInternetDialog(context);
  }

  void NoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: const Icon(
            Icons.error,
            color: Colors.white,
            size: 48.0,
          ),
          content: const Text(
            'No Internet Connection',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future CheckUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          ActiveConnection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        ActiveConnection = false;
      });
    }
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
