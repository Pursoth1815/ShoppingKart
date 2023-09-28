// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingkart/Pages/Home.dart';
import 'package:shoppingkart/Pages/Splash.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping Kart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      getPages: [
        // Define your app's routes using GetPage
        GetPage(name: '/splash', page: () => const Splash()),
        GetPage(name: '/home', page: () => const Home()),
        // Add more routes as needed
      ],
    );
  }
}
