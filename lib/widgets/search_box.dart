import 'package:flutter/material.dart';
import 'package:social_media/app/util/const.dart';

class SearchBoxWidget extends StatelessWidget {
  SearchBoxWidget(
      {required this.width,
      required this.height,
      required this.color,
      required this.suffixIcon,
      required this.textBox,
      super.key,
      required this.controller});
  double width, height;
  Color color;
  Icon suffixIcon;
  Text textBox;
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: color),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            suffixIcon,
            spaceWidth(context),
            Expanded(
                child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search...',
                  hintStyle: smallTextStyle(context, color: color, size: 18)),
            ))
          ],
        ),
      ),
    );
  }
}
