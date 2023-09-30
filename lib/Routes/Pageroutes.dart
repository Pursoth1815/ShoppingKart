// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:shoppingkart/Pages/Home.dart';
import 'package:shoppingkart/Pages/Splash.dart';
import 'package:shoppingkart/Pages/ViewProduct.dart';

import 'Routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const Splash(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const Home(),
    ),
    GetPage(
      name: Routes.VIEW_PRODUCT,
      page: () => const ViewProduct(),
    )
  ];
}
