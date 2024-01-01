import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/store/app_store.dart';

class ReviewMiddleWare extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    bool firstRun = AppStore.to.firstRun;
    return firstRun ? const RouteSettings(name: RouteName.loginRoute) : null;
  }
}
