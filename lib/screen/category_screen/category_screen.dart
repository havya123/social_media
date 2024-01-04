import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:social_media/manage/controller/category_controller.dart';
import 'package:social_media/screen/friend_screen/friend_screen.dart';
import 'package:social_media/screen/home_screen/home_screen.dart';
import 'package:social_media/screen/list_chat_screen/list_chat_screen.dart';
import 'package:social_media/screen/notification_screen/notification_screen.dart';
import 'package:social_media/screen/profile_screen/profile_screen.dart';

class CategoryScreen extends GetView<CategoryController> {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PersistentTabController controller = PersistentTabController();
    List<Widget> widgets = [
      const HomeScreen(),
      const FriendScreen(),
      const NotificationScreen(),
      const ListChatScreen(),
      const ProfileScreen()
    ];

    List<PersistentBottomNavBarItem> barItem = [
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: const Color(0xff436CFC)),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.userGroup),
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: const Color(0xff436CFC)),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.bell),
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: const Color(0xff436CFC)),
      PersistentBottomNavBarItem(
          icon: const Icon(FontAwesomeIcons.message),
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: const Color(0xff436CFC)),
      PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveColorPrimary: Colors.grey,
          activeColorPrimary: const Color(0xff436CFC)),
    ];

    return PersistentTabView(
      navBarStyle: NavBarStyle.style2,
      controller: controller,
      context,
      screens: widgets,
      items: barItem,
      decoration: NavBarDecoration(
          border: Border.all(width: 1),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
    );
  }
}
