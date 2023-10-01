// ignore_for_file: file_names, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingkart/Model/CategoryModel.dart';
import 'package:shoppingkart/Model/ProductModel.dart';
import 'package:shoppingkart/Model/SubCategoryModel.dart';
import 'package:shoppingkart/Utils/apiURL.dart';

class ProductListController extends GetxController {
  //Item Select
  RxInt selectedFoodCard = 100.obs;

  //Models
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subCategoryList = <SubCategoryModel>[].obs;
  RxList<ProductModel> productList = <ProductModel>[].obs;
  RxList<ProductModel> filteredProductList = <ProductModel>[].obs;

  //TextView Controller
  TextEditingController textController = TextEditingController();

  //Bool Variables
  RxBool catApiCalled = false.obs;
  RxBool searchEnable = false.obs;

  void setPosition(int index) {
    selectedFoodCard.value = index;
  }

  void filterProducts() {
    String query = textController.text.toLowerCase();
    searchEnable.value = true;
    filteredProductList.assignAll(
      productList.where((product) {
        return product.name.toLowerCase().contains(query);
      }),
    );
  }

  void fetchCategory() async {
    const organizationId = 1;

    try {
      final response = await http
          .get(Uri.parse('$categoryListApi?OrganizationId=$organizationId'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        categoryList.clear();

        if (jsonResponse['Code'] == 200 && jsonResponse['Status'] == true) {
          List<dynamic> data = jsonResponse['Data'];

          categoryList.addAll(
            data.map(
              (jsonItem) => CategoryModel.fromJson(jsonItem),
            ),
          );

          categoryList.sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }
    } on SocketException catch (e) {
      log("Socket Exeception $e");
    } catch (e) {
      log("$e");
    }
  }

  void fetchSubCategory(String categoryID) async {
    const organizationId = 1;
    catApiCalled.value = true;

    try {
      final response = await http.get(Uri.parse(
          '$subCategoryListApi?OrganizationId=$organizationId&CategoryCode=$categoryID'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        subCategoryList.clear();

        if (jsonResponse['Code'] == 200 && jsonResponse['Status'] == true) {
          List<dynamic> data = jsonResponse['Data'];

          subCategoryList.addAll(
            data.map(
              (jsonItem) => SubCategoryModel.fromJson(jsonItem),
            ),
          );

          subCategoryList
              .sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
        }
      }
    } on SocketException catch (e) {
      log("Socket Exeception $e");
    } catch (e) {
      log("$e");
    }
  }

  void fetchProducts(String categoryID, String subCategoryID) async {
    const organizationId = 1;
    catApiCalled.value = true;
    searchEnable.value = false;
    textController.text = '';

    try {
      final response = await http.get(Uri.parse(
          '$productListApi?OrganizationId=$organizationId&CategoryCode=$categoryID&SubCategory=$subCategoryID'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        productList.clear();

        if (jsonResponse['Code'] == 200 && jsonResponse['Status'] == true) {
          if (jsonResponse['TotalNumberOfRecords'] > 0 &&
              jsonResponse['Result'] != null) {
            List<dynamic> data = jsonResponse['Result'];
            log("$data");
            productList.addAll(
              data.map(
                (jsonItem) => ProductModel.fromJson(jsonItem),
              ),
            );
          }
        }
      }
    } on SocketException catch (e) {
      log("Socket Exeception $e");
    } catch (e) {
      log("$e");
    }
  }
}
