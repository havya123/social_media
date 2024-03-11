import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_media/app/util/const.dart';
import 'package:transparent_image/transparent_image.dart';

class PostWidget extends StatelessWidget {
  PostWidget({super.key, required this.content, required this.imageUrl});
  String content, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: getHeight(context, height: 0.8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: getWidth(context),
                  ),
                  const Text("User"),
                ],
              ),
            ),
          ),
          spaceHeight(context),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(content),
              )),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage, image: imageUrl),
            ),
          ),
          const Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(FontAwesomeIcons.heart),
                    Icon(FontAwesomeIcons.message),
                    Icon(FontAwesomeIcons.share),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
