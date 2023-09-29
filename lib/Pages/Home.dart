// ignore_for_file: depend_on_referenced_packages, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shoppingkart/Utils/imagePath.dart';

import '../Controller/ProductListController.dart';
import '../Utils/colors.dart';

class Home extends GetView<productListController> {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => productListController());
    controller.fetchCategory();

    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () {
            return controller.categoryList.isEmpty
                ? controller.SE == true
                    ? getBodyDesign()
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
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Categories',
                style: TextStyle(
                  color: colorSplashtext,
                  height: 1.3,
                  fontFamily: 'Poppins',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(
            height: 240,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: /* controller.categoryList.length */ controller.testItemCount.toInt(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                    child: categoryCardDesign(index),
                  ),
                )),
          ),
        ],
      )),
    );
  }

  Widget categoryCardDesign(int index) {
    return GestureDetector(
        onTap: () => {
              controller.setPosition(index),
              controller.testItemCount = RxInt(4),
            },
        child: Container(
          margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: controller.selectedFoodCard == index ? colorprimary : colorWhite, boxShadow: const [
            BoxShadow(
              color: colorlightGray,
              blurRadius: 15,
            )
          ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(logo, width: 40),
              const Text(
                /* controller.categoryList[index].name */ 'Test',
                style: TextStyle(
                  color: colorSplashtext,
                  height: 1.3,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              RawMaterialButton(
                  onPressed: null,
                  fillColor: controller.selectedFoodCard == index ? colorWhite : colorSplashtext,
                  shape: const CircleBorder(),
                  child: Icon(Icons.chevron_right_rounded, size: 20, color: controller.selectedFoodCard == index ? colorblack : colorWhite))
            ],
          ),
        ));
  }
}
