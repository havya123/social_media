import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media/app/util/const.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {required this.function,
      super.key,
      this.textButton = "",
      this.listColor = const [
        Color(0xff363ff5),
        Color(0xff6357CC),
      ],
      this.textColor = Colors.white,
      this.border = false,
      this.colorBorder = Colors.red});
  final VoidCallback function;
  final String textButton;
  final List<Color> listColor;
  final Color textColor;
  final bool border;
  final Color colorBorder;
  @override
  Widget build(BuildContext context) {
    var isLoading = false.obs;
    return InkWell(
      onTap: () async {
        if (isLoading.value) return;
        isLoading.value = !isLoading.value;
        await Future.delayed(const Duration(seconds: 1));
        isLoading.value = !isLoading.value;
        function();
      },
      child: Ink(
        child: Container(
          width: double.infinity,
          height: getHeight(context, height: 0.08),
          decoration: BoxDecoration(
              border: border ? Border.all(color: colorBorder) : null,
              gradient: LinearGradient(colors: listColor),
              borderRadius: BorderRadius.circular(20)),
          child: Obx(
            () => Center(
              child: !isLoading.value
                  ? Text(
                      textButton,
                      style: TextStyle(
                          color: textColor,
                          fontSize: 19,
                          fontWeight: FontWeight.bold),
                    )
                  : const CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }
}
