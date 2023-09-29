// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shoppingkart/Model/CategoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingkart/Utils/apiURL.dart';

class productListController extends GetxController {
  RxBool SE = false.obs;
  RxInt selectedFoodCard = 0.obs;
  RxInt testItemCount = 5.obs;
  var categoryList = <CategoryModel>[].obs;

  void setPosition(int index) {
    selectedFoodCard = RxInt(index);
  }

  void fetchCategory() async {
    const organizationId = 1;

    try {
      final response = await http.get(Uri.parse('$categoryListApi?OrganizationId=$organizationId'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        categoryList.clear();

        categoryList.addAll(
          jsonResponse.map(
            (jsonItem) => CategoryModel.fromJson(jsonItem),
          ),
        );
      }
    } on SocketException catch (e) {
      log("Socket Exeception $e");
      SE.value = true;
    } catch (e) {
      log("$e");
    }
  }
}
