import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/manage/controller/register_controller.dart';

class CategoryMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String statusAccount = AppStore.to.statusAccount.value;
    if (statusAccount == "old") {
      return null;
    }
    return const RouteSettings(name: RouteName.informationRoute);
  }
}
