import 'package:flutter/material.dart';

import '../core/utility/app_colors.dart';

class DescriptionContainer extends StatelessWidget {
  const DescriptionContainer({Key? key, required this.title, required this.img}) : super(key: key);

  final String title;
  final String img;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),),
            const SizedBox(width: 5,),
            ImageIcon(AssetImage(img)),
          ],
        ),
      ),
    );
  }
}
