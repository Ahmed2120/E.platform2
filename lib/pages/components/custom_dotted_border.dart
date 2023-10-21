import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';

class CustomDottedBorder extends StatelessWidget {
  CustomDottedBorder({required this.child, Key? key}) : super(key: key);

  Widget child;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(20),
      dashPattern: [10, 10],
      color: AppColors.primaryColor,
      strokeWidth: 2,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: child,
      ),
    );
  }
}
