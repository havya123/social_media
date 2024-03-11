import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/app/store/app_store.dart';
import 'package:social_media/app/store/services.dart';
import 'package:social_media/firebase_options.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/route/router_custom.dart';
import 'package:social_media/manage/bindings/review_bindings.dart';
import 'package:social_media/manage/controller/register_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Get.putAsync(
    () => AppServices().init(),
  );
  await clearData();
  Get.put(AppStore());
  Get.put(RegisterController());
  await Future.delayed(const Duration(seconds: 2), () {});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: ReviewBinding(),
      initialRoute: RouteName.reviewRoute,
      getPages: RouteManager().getPage,
    );
  }
}

Future<void> clearData() async {
  var prefs = await SharedPreferences.getInstance();
  prefs.clear();
}
