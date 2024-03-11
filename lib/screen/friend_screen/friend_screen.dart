import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/friend_controller.dart';
import 'package:social_media/widgets/detail_tab.dart';
import 'package:social_media/widgets/friend_request_widget.dart';
import 'package:social_media/widgets/search_box.dart';

class FriendScreen extends StatelessWidget {
  const FriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FriendController(),
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.arrow_back_ios),
                      Expanded(
                          child: Center(
                        child: Text(
                          "Discorver Now",
                          style: largeTextStyle(context, size: 25),
                        ),
                      )),
                    ],
                  ),
                  spaceHeight(context),
                  SearchBoxWidget(
                      width: getWidth(context, width: 0.7),
                      height: getHeight(context, height: 0.08),
                      color: const Color(0xff437DFF),
                      suffixIcon: const Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        color: Color(0xff437DFF),
                      ),
                      textBox: const Text("Search"),
                      controller: TextEditingController()),
                  spaceHeight(context),
                  DefaultTabController(
                      length: controller.listType.length,
                      child: Column(
                        children: [
                          TabBar(
                            indicatorColor: const Color(0xff3A3F47),
                            indicatorWeight: 4.0,
                            unselectedLabelStyle: smallTextStyle(context),
                            labelColor: Colors.black,
                            labelStyle: mediumTextStyle(
                              context,
                            ),
                            isScrollable: true,
                            tabs: controller.listType
                                .map(
                                  (e) => Tab(text: e),
                                )
                                .toList(),
                            onTap: (value) => controller.changeTab(value),
                          ),
                          spaceHeight(context),
                          Obx(() {
                            return DetailTabs(
                                index: controller.currentTab.value);
                          })
                        ],
                      )),
                ],
              ),
            ),
          )),
        );
      },
    );
  }
}
