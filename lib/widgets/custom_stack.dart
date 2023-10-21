import 'package:flutter/material.dart';

import '../core/utility/app_colors.dart';
import '../pages/components/row_title.dart';

class CustomStack extends StatelessWidget {
  const CustomStack({Key? key, required this.pageTitle, required this.child, this.button}) : super(key: key);

  final String pageTitle;
  final Widget child;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            color: AppColors.primaryColor,
          ),
          Container(
            margin: EdgeInsets.only(top: deviceSize.height * 0.08),
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
                color: AppColors.pageBackgroundColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
              child: child,),
          ),
          // CustomRowTitle(title: pageTitle)
          Padding(
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
                Text(pageTitle,
                    style: const TextStyle(fontSize: 20,
                        color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),
                if(button == null) const SizedBox(width: 32.0),
                if(button != null) button!

              ],
            ),
          )
        ],
      ),
    );
  }
}
