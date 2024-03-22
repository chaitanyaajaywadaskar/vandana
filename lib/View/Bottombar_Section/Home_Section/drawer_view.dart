import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/layout_constant.dart';
import 'package:vandana/Constant/storage_key_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';
import 'package:vandana/Custom_Widgets/custom_button.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Initial_Section/get_start_view.dart';

import '../Tiffin_Order/tiffin_order_view.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  RxString userName = "".obs;
  RxString userEmail = "".obs;

  @override
  void initState() {
    super.initState();
    initialFunctioun();
  }

  initialFunctioun() async {
    userName.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userName) ??
        "";
    userEmail.value = await StorageServices.getData(
            dataType: StorageKeyConstant.stringType,
            prefKey: StorageKeyConstant.userEmail) ??
        "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.orange,
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.height * 0.050,
            left: screenWidthPadding,
            right: screenWidthPadding,
            bottom: screenHeightPadding),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: Get.width * 0.020),
                  child: CircleAvatar(
                    radius: Get.width * 0.072,
                    backgroundImage: const NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1DIVMNOgmDWXjhYBbM-DIhe69hWq2t1k1ULKDF80_59k5EtmZB_-7ewVFiGihhC3G538&usqp=CAU"),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName.value,
                      style:
                          TextStyleConstant.bold18(color: ColorConstant.white),
                    ),
                    Text(
                      userEmail.value,
                      style: TextStyleConstant.regular14(
                          color: ColorConstant.white),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * 0.030),
              child: drawerWidget(
                tabName: "My Tiffin",
                icon: Icons.home_repair_service_outlined,
                onTap: () {},
              ),
            ),
            drawerWidget(
              tabName: "My Tiffin Order",
              icon: Icons.account_box_outlined,
              onTap: () {
                Get.to(() => const TiffinOrderView());
              },
            ),
            drawerWidget(
              tabName: "About Us",
              icon: Icons.account_box_outlined,
              onTap: () {},
            ),
            drawerWidget(
              tabName: "Contact Us",
              icon: Icons.supervisor_account_outlined,
              onTap: () {},
            ),
            drawerWidget(
              tabName: "Support Us",
              icon: Icons.support_agent_sharp,
              onTap: () {},
            ),
            drawerWidget(
              tabName: "Term & Conditions",
              icon: Icons.menu_book_rounded,
              onTap: () {},
            ),
            drawerWidget(
              tabName: "Privacy Policy",
              icon: Icons.lock,
              onTap: () {},
            ),
            const Spacer(),
            CustomButton(
              title: "Log Out",
              backGroundColor: ColorConstant.white,
              textColor: ColorConstant.orange,
              onTap: () async {
                await StorageServices.clearData();
                Get.offAll(() => const GetStartView());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerWidget(
      {required Function() onTap,
      required String tabName,
      required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: ColorConstant.white),
            Text(
              tabName,
              style: TextStyleConstant.medium16(color: ColorConstant.white),
            ),
          ],
        ),
      ),
    );
  }
}
