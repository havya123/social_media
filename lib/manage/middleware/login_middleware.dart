import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/route_middleware.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';

class LoginMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    String uid = AppStore.to.token;
    if (uid != "") {
      if (JwtDecoder.isExpired(AppStore.to.token)) {
        return null;
      } else {
        return const RouteSettings(name: RouteName.categoryRoute);
      }
    }
    return null;
  }
  // if (uid != "" && statusAccount == "old") {
  //   return const RouteSettings(name: RouteName.categoryRoute);
  // }
  // if (uid != "" && statusAccount == "new") {
  //   return const RouteSettings(name: RouteName.informationRoute);
  // }
  // return null;
}
