import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle(this.title, {Key? key, this.centerTitle = false}) : super(key: key);

  final String title;
  final bool centerTitle;
  // final double size;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: centerTitle ? TextAlign.center : null,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.titleColor),
    );
  }
}