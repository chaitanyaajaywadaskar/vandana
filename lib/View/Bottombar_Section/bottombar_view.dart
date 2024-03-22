import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Controllers/bottombar_controller.dart';

class BottomBarView extends StatefulWidget {
  final int? index;

  const BottomBarView({super.key, this.index});

  @override
  State<BottomBarView> createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView> {
  BottomBarController controller = Get.put(BottomBarController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted) {
        if (widget.index != null) {
          controller.selectedIndex.value = widget.index!;
          controller.update();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.viewsList[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.024, vertical: Get.width * 0.016),
        decoration: BoxDecoration(
          color: ColorConstant.orangeAccent,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            )
          ],
        ),
        child: GNav(
          rippleColor: ColorConstant.orangeAccent,
          hoverColor: ColorConstant.orangeAccent,
          gap: Get.width * 0.024,
          activeColor: ColorConstant.white,
          iconSize: 24,
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.048, vertical: Get.height * 0.014),
          duration: const Duration(seconds: 1),
          tabBackgroundColor: ColorConstant.orange,
          backgroundColor: ColorConstant.orangeAccent,
          color: ColorConstant.white,
          tabs: const [
            GButton(
              icon: Icons.home_outlined,
              text: 'Home',
            ),
            GButton(
              icon: Icons.lunch_dining_outlined,
              text: 'Food',
            ),
            GButton(
              icon: Icons.card_travel_rounded,
              text: 'Tifin',
            ),
            GButton(
              icon: Icons.person_2_outlined,
              text: 'Profile',
            ),
          ],
          selectedIndex: controller.selectedIndex.value,
          onTabChange: (index) {
            controller.selectedIndex.value = index;
          },
        ),
      ),
    );
  }
}
