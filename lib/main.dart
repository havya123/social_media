import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/manage/bindings/home_bindings.dart';
import 'package:social_media/route/route_name.dart';
import 'package:social_media/route/router_custom.dart';
import 'package:social_media/screen/home_screen/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const HomeScreen(),
      initialBinding: HomeBinding(),
      initialRoute: RouteName.homeRoute,
      getPages: RouteManager().getPage,
    );
  }
}
