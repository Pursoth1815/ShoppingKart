// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingkart/Controller/ProductListController.dart';
import 'package:shoppingkart/Routes/Pageroutes.dart';
import 'package:shoppingkart/Routes/Routes.dart';

void main() {
  Get.put(ProductListController());
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
        initialRoute: Routes.INITIAL,
        getPages: AppPages.pages);
  }
}
