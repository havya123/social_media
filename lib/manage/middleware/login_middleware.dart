import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/manage/controller/register_controller.dart';

class LoginMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String uid = AppStore.to.uid;
    String statusAccount =
        RegisterController.to.user.value?.statusAccount ?? "";

    if (uid != "" && statusAccount == "old") {
      return const RouteSettings(name: RouteName.categoryRoute);
    }
    if (uid != "" && statusAccount == "new") {
      return const RouteSettings(name: RouteName.informationRoute);
    }
    return null;
  }
}
