import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/drawer_view.dart';
import 'package:vandana/View/Bottombar_Section/bottombar_view.dart';

import '../../Controllers/profile_controller.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final drawerController = ZoomDrawerController();
  final profileController = Get.put(ProfileController());
  @override
  void initState() {
    super.initState();
    profileController.initialFunctioun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: drawerController,
        style: DrawerStyle.defaultStyle,
        menuScreen: const DrawerView(),
        mainScreen: const BottomBarView(),
        borderRadius: 24,
        showShadow: true,
        angle: 0.0,
        menuBackgroundColor: ColorConstant.orange,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}
