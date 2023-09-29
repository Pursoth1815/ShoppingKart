// ignore_for_file: depend_on_referenced_packages, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Common/notfound.dart';
import '../Controller/ProductListController.dart';
import '../Utils/colors.dart';

class Home extends GetView<productListController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => productListController());
    controller.fetchPosts();

    return Scaffold(body: Obx(
      () {
        return controller.categoryList.isEmpty
            ? controller.SE == true
                ? const NotFound()
                : const Center(child: CircularProgressIndicator())
            : getBodyDesign();
      },
    ));
  }

  Container getBodyDesign() {
    return Container(
      width: Get.width,
      height: Get.height,
      color: colorSplashBG,
    );
  }
}
