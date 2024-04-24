import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

class CustomNoDataFoundWithJson extends StatelessWidget {
  final String? message;

  const CustomNoDataFoundWithJson({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          'assets/lottie/no_data.json',
          height: 200,
        ),
        Center(
          child: Text(
            message ?? "No Data Found",
            style: TextStyleConstant.semiBold24(),
          ),
        ),
      ],
    );
  }
}
