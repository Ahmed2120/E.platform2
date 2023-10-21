import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';

class CustomRowTitle extends StatelessWidget {
  const CustomRowTitle({required this.title, Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: ()=> Navigator.pop(context),
            icon: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5)
              ),
              child: const Icon(Icons.arrow_forward_ios_sharp,
                color: AppColors.primaryColor, size: 15,
                textDirection: TextDirection.ltr,
              ),
            ),
          ),
          Text(title,
              style: const TextStyle(fontSize: 20,
                  color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),
          const SizedBox(width: 32.0),

        ],
      ),
    ) ;
  }
}
