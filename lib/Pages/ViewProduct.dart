// ignore_for_file: depend_on_referenced_packages, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoppingkart/Common/Appbar.dart';
import 'package:shoppingkart/Controller/ProductListController.dart';
import 'package:shoppingkart/Utils/colors.dart';
import 'package:shoppingkart/Utils/imagePath.dart';

class ViewProduct extends GetView {
  const ViewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListController controller = Get.find();
    return WillPopScope(
      onWillPop: () async {
        controller.productList.clear();
        return true;
      },
      child: Scaffold(
          appBar: CommonAppBar(title: "View Products"),
          backgroundColor: colorWhite,
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: Get.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorTaleColor),
                    borderRadius: BorderRadius.circular(30.0),
                    color: colorSplashBG,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 4,
                        child: TextField(
                          controller: controller.textController,
                          decoration: const InputDecoration(
                            hintText: 'Search Products',
                            hintStyle:
                                TextStyle(fontSize: 18, color: colorTextColor),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 12.0),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: colorTaleColor,
                          ),
                          onPressed: () {
                            controller.filterProducts();
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(15),
                    child: getProductList(context, controller)),
              ],
            ),
          )),
    );
  }

  Widget getProductList(
      BuildContext context, ProductListController controller) {
    return Obx(() => controller.productList.isEmpty
        ? noDataFound()
        : getProducts(controller, context));
  }

  Obx getProducts(ProductListController controller, BuildContext context) {
    return Obx(
      () => GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 280,
        ),
        itemCount: controller.searchEnable.value
            ? controller.filteredProductList.length
            : controller.productList.length,
        itemBuilder: (_, index) {
          final product = controller.searchEnable.value
              ? controller.filteredProductList[index]
              : controller.productList[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(16.0), // Adjust the radius as needed
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      product.categoryImage!,
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                                const TextStyle(
                                  fontSize: 18,
                                  color: colorTextColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          "₹ ${product.prize}",
                          style: Theme.of(context).textTheme.titleSmall!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  color: colorDarkRedColor,
                                ),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
}
