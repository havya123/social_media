import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/manage/controller/profile_controller.dart';
import 'package:social_media/widgets/tab_widget.dart';

class TabScreen extends StatelessWidget {
  const TabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: ProfileController(),
        builder: (controller) {
          return DefaultTabController(
              initialIndex: controller.currentTab.value,
              length: controller.listTab.length,
              child: Column(
                children: [
                  TabBar(
                    indicatorColor: const Color(0xff3A3F47),
                    indicatorWeight: 2.0,
                    unselectedLabelStyle: smallTextStyle(context),
                    labelColor: Colors.black,
                    labelStyle: mediumTextStyle(context),
                    isScrollable: true,
                    tabs: controller.listTab
                        .map((e) => Tab(
                              text: e,
                            ))
                        .toList(),
                    onTap: (value) {
                      controller.changeTab(value);
                    },
                  ),
                  spaceHeight(context),
                  TabWidget(index: controller.currentTab.value),
                ],
              ));
        });
  }
}
