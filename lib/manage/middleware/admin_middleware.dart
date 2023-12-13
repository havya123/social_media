import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminMiddleWare extends GetMiddleware {
  @override
  final int priority;

  AdminMiddleWare({this.priority = 1});

  @override
  RouteSettings? redirect(String? route) {
    bool login = false;
    return null;
  }
}
