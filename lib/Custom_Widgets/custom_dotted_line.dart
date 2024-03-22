import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';

class HorizontalDottedLine extends StatelessWidget {
  const HorizontalDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.001,
      width: double.infinity, // Adjust the height of the line as needed
      child: CustomPaint(
        painter: HorizontalDottedLinePainter(),
      ),
    );
  }
}

class HorizontalDottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = ColorConstant.orange // Set the color of the dotted line
      ..strokeWidth = 1.0 // Adjust the thickness of the dotted line
      ..strokeCap = StrokeCap.round;

    double dashWidth = Get.width * 0.012;
    double dashSpace = Get.height * 0.003;

    double startX = 0.0;
    double endX = size.width;

    double currentX = startX;

    while (currentX < endX) {
      canvas.drawLine(Offset(currentX, size.height / 2),
          Offset(currentX + dashWidth, size.height / 2), paint);
      currentX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
