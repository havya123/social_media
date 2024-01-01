import 'package:get/get.dart';
import 'package:social_media/manage/bindings/category_bindings.dart';
import 'package:social_media/manage/bindings/home_bindings.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/manage/bindings/register_bindings.dart';
import 'package:social_media/manage/bindings/reivew_bindings.dart';
import 'package:social_media/manage/middleware/review_middleware.dart';
import 'package:social_media/screen/category_screen/category_screen.dart';
import 'package:social_media/screen/login_screen/login_screen.dart';
import 'package:social_media/screen/register_screen/phone_register/otp_screen.dart';
import 'package:social_media/screen/register_screen/phone_register/password_screen.dart';
import 'package:social_media/screen/register_screen/phone_register/phone_register_screen.dart';
import 'package:social_media/screen/register_screen/register_screen.dart';
import 'package:social_media/screen/review_screen/review_screen.dart';

class RouteManager {
  final getPage = [
    GetPage(
      name: RouteName.reviewRoute,
      page: () => const ReviewScreen(),
      binding: ReviewBinding(),
      middlewares: [ReviewMiddleWare()],
    ),
    GetPage(
      name: RouteName.loginRoute,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteName.categoryRoute,
      page: () => const CategoryScreen(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: RouteName.registerRoute,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.phoneRegisterRoute,
      page: () => const PhoneRegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.otpRoute,
      page: () => const OTPScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.passwordRoute,
      page: () => const PasswordScreen(),
      binding: RegisterBinding(),
    )
  ];
}
