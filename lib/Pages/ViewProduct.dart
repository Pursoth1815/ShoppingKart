// ignore_for_file: depend_on_referenced_packages, file_names

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingkart/Controller/ProductListController.dart';
import 'package:shoppingkart/Utils/colors.dart';

class ViewProduct extends GetView {
  const ViewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListController controller = Get.find();
    log("${controller.selectedFoodCard}");
    return Container(
      color: colorSplashtext,
      width: Get.width,
      height: Get.height,
      child: TextButton(
        child: const Text('Check me'),
        onPressed: () {
          controller.selectedFoodCard.value = 0;
          Get.toNamed('/home');
        },
      ),
    );
  }
}
