import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:meteoapp/pages/home.dart';
import 'package:meteoapp/theme/appTheme.dart';
import 'package:meteoapp/theme/themeController.dart';

void main() {
  Get.put(Themecontroller());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Themecontroller themeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeController.themeMode.value,
      theme: Apptheme.lightTheme,
      darkTheme: Apptheme.darkTheme,

      home: Home(),
    );
  }
}
