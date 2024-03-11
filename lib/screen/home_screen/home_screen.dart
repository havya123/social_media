import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:social_media/app/route/route_name.dart';
import 'package:social_media/app/util/const.dart';
import 'package:social_media/widgets/input_widget.dart';
import 'package:social_media/widgets/post_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                color: Colors.white,
                width: double.infinity,
                height: getHeight(context, height: 0.25),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Social App",
                        style: TextStyle(
                            color: Color(0xff0019FF),
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      spaceHeight(context),
                      TextFieldWidget(
                        hint: "Search",
                        icon: const Icon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Color(0xff696ADA),
                        ),
                        removeBorder: true,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => Get.toNamed(RouteName.createPostRoute),
                      child: Container(
                        width: double.infinity,
                        height: getHeight(context, height: 0.1),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 5,
                                  color: Colors.grey)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: getWidth(context),
                            ),
                            const Icon(
                              FontAwesomeIcons.pen,
                              color: Color(0xff699CFF),
                            ),
                            SizedBox(
                              width: getWidth(context),
                            ),
                            const Text("Chia sẽ suy nghĩ của bạn...")
                          ],
                        ),
                      ),
                    ),
                    spaceHeight(context, height: 0.02),
                    Row(
                      children: [
                        const Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.image,
                              color: Color(0xffFF9900),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Đăng ảnh")
                          ],
                        ),
                        SizedBox(
                          width: getWidth(context, width: 0.1),
                        ),
                        const Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.youtube,
                              color: Color(0xffEA5A47),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Đăng video")
                          ],
                        )
                      ],
                    ),
                    spaceHeight(context),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container();
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: getHeight(context, height: 0.08),
                          );
                        },
                        itemCount: 5)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
