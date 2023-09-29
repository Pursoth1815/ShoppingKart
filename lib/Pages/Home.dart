// ignore_for_file: depend_on_referenced_packages, file_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingkart/Controller/ProductListController.dart';
import 'package:shoppingkart/Utils/imagePath.dart';

import '../Utils/colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListController controller = Get.find();
    controller.fetchCategory();

    return Scaffold(
        appBar: AppBar(),
        body: Obx(
          () {
            return controller.categoryList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : getBodyDesign(controller);
          },
        ));
  }

  Container getBodyDesign(ProductListController controller) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: colorSplashBG,
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 20, top: 20),
              child: Text(
                'Categories',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: colorTextColor,
                  height: 1.5,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              )),
          SizedBox(
            height: 240,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                    child: categoryCardDesign(controller, index),
                  ),
                )),
          ),
        ],
      )),
    );
  }

  Widget categoryCardDesign(ProductListController controller, int index) {
    return Obx(() => GestureDetector(
        onTap: () => {
              controller.setPosition(index),
            },
        child: Container(
          width: 150,
          margin: const EdgeInsets.only(right: 20, top: 20, bottom: 20),
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: controller.selectedFoodCard.value == index
                  ? colorprimary
                  : colorWhite,
              boxShadow: const [
                BoxShadow(
                  color: colorlightGray,
                  blurRadius: 15,
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                  controller.categoryList[index].categoryImage == ''
                      ? imageError
                      : controller.categoryList[index].categoryImage!,
                  width: 50),
              Text(
                controller.categoryList[index].name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: colorSplashtext,
                  height: 1.3,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              RawMaterialButton(
                  onPressed: null,
                  fillColor: controller.selectedFoodCard.value == index
                      ? colorWhite
                      : colorSplashtext,
                  shape: const CircleBorder(),
                  child: Icon(Icons.chevron_right_rounded,
                      size: 20,
                      color: controller.selectedFoodCard.value == index
                          ? colorblack
                          : colorWhite))
            ],
          ),
        )));
  }
}
