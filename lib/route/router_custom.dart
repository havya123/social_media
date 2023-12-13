import 'package:get/get.dart';
import 'package:social_media/manage/bindings/category_bindings.dart';
import 'package:social_media/manage/bindings/home_bindings.dart';
import 'package:social_media/route/route_name.dart';
import 'package:social_media/screen/category_screen/category_screen.dart';
import 'package:social_media/screen/home_screen/home_screen.dart';

class RouteManager {
  final getPage = [
    GetPage(
      name: RouteName.homeRoute,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteName.categoryRoute,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),
  ];
}
