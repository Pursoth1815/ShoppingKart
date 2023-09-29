import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              notfound,
              width: Get.width,
              height: Get.width,
            ),
          ),
          Text('Oops!', style: GoogleFonts.getFont('Libre Baskerville', fontSize: 45))
        ],
      ),
    );
  }
}
