import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Utils/colors.dart';
import '../Utils/imagePath.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: colorWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            notfound,
            width: 250,
            height: 250,
          ),
        ],
      ),
    );
  }
}
