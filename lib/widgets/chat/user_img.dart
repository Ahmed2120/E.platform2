import 'package:flutter/material.dart';

import '../../pages/components/show_network_image.dart';

class UserImg extends StatelessWidget {
  const UserImg({Key? key, required this.img, this.isActive = false}) : super(key: key);

  final String img;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShowNetworkImage(img: img, isCircle: true, size: 60,),
        if(isActive) Positioned(
          right: 0,
          bottom: 10,
          child: Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green
            ),
          ),
        ),
      ],
    );
  }
}
