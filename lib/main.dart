import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vandana/Services/storage_services.dart';
import 'package:vandana/View/Initial_Section/splash_view.dart';

import 'View/Bottombar_Section/Tiffin_Order/tiffin_order_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageServices.initializeSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashView(),
      // home: TiffinOrderView(),
    );
  }
}
