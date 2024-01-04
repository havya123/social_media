import 'package:flutter/material.dart';

Size size(context) => MediaQuery.sizeOf(context);

double getHeight(context, {double height = 0.04}) =>
    size(context).height * height;

double getWidth(context, {double width = 0.04}) => size(context).width * width;

SizedBox spaceHeight(context, {double height = 0.04}) => SizedBox(
      height: size(context).height * height,
    );

SizedBox spaceWidth(context, {double width = 0.04}) => SizedBox(
      width: size(context).width * width,
    );
