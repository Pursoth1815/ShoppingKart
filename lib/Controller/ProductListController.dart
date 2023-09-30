// ignore_for_file: file_names, depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingkart/Model/CategoryModel.dart';
import 'package:shoppingkart/Model/SubCategoryModel.dart';
import 'package:shoppingkart/Utils/apiURL.dart';

class ProductListController extends GetxController {
  //Item Select
  RxInt selectedFoodCard = 100.obs;

  //Models
  RxList<CategoryModel> categoryList = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subCategoryList = <SubCategoryModel>[].obs;

  //Bool Variables
  RxBool catApiCalled = false.obs;
  void setPosition(int index) {
    selectedFoodCard.value = index;
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

          log("YES");

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
}
