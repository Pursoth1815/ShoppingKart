// ignore_for_file: depend_on_referenced_packages, file_names, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingkart/Common/Appbar.dart';
import 'package:shoppingkart/Controller/ProductListController.dart';
import 'package:shoppingkart/Utils/imagePath.dart';

import '../Utils/colors.dart';

class Home extends GetView {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListController controller = Get.find();
    controller.fetchCategory();

    return Scaffold(
        appBar: CommonAppBar(title: 'Shoping Kart'),
        body: Obx(
          () {
            return controller.categoryList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : getBodyDesign(controller);
          },
        ));
  }

  //***************************** Body Design ****************************/

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
            height: 250,
            child: Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: index == 0 ? 25 : 0),
                    child: categoryCardDesign(controller, index),
                  ),
                )),
          ),
          Visibility(
            visible: controller.catApiCalled.value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Sub Categories',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: colorTextColor,
                        height: 1.5,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                controller.subCategoryList.isNotEmpty
                    ? SubCategoryCardDesign(controller)
                    : noDataFound(),
              ],
            ),
          ),
        ],
      )),
    );
  }

  //***************************** Sub Category Card Design ****************************/

  Container SubCategoryCardDesign(ProductListController controller) =>
      Container(
        width: Get.width,
        height: Get.height,
        color: colorSplashBG,
        margin: const EdgeInsets.all(20),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0),
            itemCount: controller.subCategoryList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: colorWhite,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                          child: Image.asset(
                        controller.subCategoryList[index].categoryImage == ''
                            ? noImage
                            : controller.subCategoryList[index].categoryImage!,
                        width: 250,
                        height: 125,
                      )),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'View Details >>',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: colorTextColor,
                            height: 1.5,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          controller.subCategoryList[index].name,
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: colorTaleColor,
                            height: 1.5,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      );

  //***************************** No Data Found Design ****************************/

  Container noDataFound() {
    return Container(
      width: Get.width,
      height: Get.width - 75,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorWhite,
            boxShadow: const [
              BoxShadow(
                color: colorlightGray,
                blurRadius: 15,
              )
            ]),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                notDatad,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'No Data Found',
                style: GoogleFonts.getFont(
                  'Poppins',
                  color: colorlightGray,
                  height: 1.5,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //***************************** Body Card Design ****************************/

  Obx categoryCardDesign(ProductListController controller, int index) {
    return Obx(() => GestureDetector(
        onTap: () => {
              controller.setPosition(index),
              controller
                  .fetchSubCategory(controller.categoryList[index].categoryCode)
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
