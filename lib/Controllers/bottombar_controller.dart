import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vandana/View/Bottombar_Section/Cart_Section/cart_view.dart';
import 'package:vandana/View/Bottombar_Section/Home_Section/home_view.dart';
import 'package:vandana/View/Bottombar_Section/Profile_Section/profile_view.dart';
import 'package:vandana/View/Bottombar_Section/Tifin_Section/tifin_services_view.dart';

class BottomBarController extends GetxController {
  RxList<Widget> viewsList = <Widget>[
    const HomeView(),
    const CartView(),
    const TifinServicesView(),
    const ProfileView(),
  ].obs;
  RxInt selectedIndex = 0.obs;
}
