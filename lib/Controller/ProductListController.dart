// ignore_for_file: file_names, depend_on_referenced_packages

import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:shoppingkart/Model/CategoryModel.dart';
import 'package:http/http.dart' as http;
import 'package:shoppingkart/Utils/apiURL.dart';

class productListController extends GetxController {
  RxBool SE = false.obs;
  var categoryList = <CategoryModel>[].obs;

  void fetchPosts() async {
    const organizationId = 1;

    try {
      final response = await http.get(Uri.parse('$categoryListApi?OrganizationId=$organizationId'));
      if (response.statusCode == 200) {
        log(response.toString());
      }
    } on SocketException catch (e) {
      log("Socket Exeception $e");
      SE.value = true;
    } catch (e) {
      log("$e");
    }
  }
}
