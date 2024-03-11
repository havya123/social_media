import 'package:get/get.dart';
import 'package:social_media/manage/bindings/category_bindings.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/manage/bindings/createPost_bindings.dart';
import 'package:social_media/manage/bindings/information_bindings.dart';
import 'package:social_media/manage/bindings/register_bindings.dart';
import 'package:social_media/manage/bindings/review_bindings.dart';
import 'package:social_media/manage/middleware/category_middleware.dart';
import 'package:social_media/manage/middleware/login_middleware.dart';
import 'package:social_media/manage/middleware/review_middleware.dart';
import 'package:social_media/screen/category_screen/category_screen.dart';
import 'package:social_media/screen/create_post_screen/create_post_screen.dart';
import 'package:social_media/screen/information_screen/information_user_screen.dart';
import 'package:social_media/screen/login_screen/login_screen.dart';
import 'package:social_media/screen/register_screen/phone_register/otp_screen.dart';
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
      binding: RegisterBinding(),
      middlewares: [LoginMiddleWare()],
    ),
    GetPage(
        name: RouteName.categoryRoute,
        page: () => const CategoryScreen(),
        binding: CategoryBinding(),
        middlewares: [CategoryMiddleWare()]),
    GetPage(
      name: RouteName.registerRoute,
      page: () => const RegisterScreen(),
      //binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.phoneRegisterRoute,
      page: () => const PhoneRegisterScreen(),
      //binding: RegisterBinding(),
    ),
    GetPage(
      name: RouteName.otpRoute,
      page: () => const OTPScreen(),
      // binding: RegisterBinding(),
    ),
    GetPage(
        name: RouteName.informationRoute,
        page: () => const InformationUser(),
        binding: InformationBinding()),
    GetPage(
      name: RouteName.createPostRoute,
      page: () => const CreatePostScreen(),
      binding: CreatePostBinding(),
    )
  ];
}
