import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({Key? key, required this.title, required this.function, this.color, this.size = 40}) : super(key: key);

  final String title;
  final Function function;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: Size(size, size),
      ),
      child: Text(title),
    );
  }
}
