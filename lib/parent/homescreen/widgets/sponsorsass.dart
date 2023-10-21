import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SponsorsASS extends StatelessWidget {
  const SponsorsASS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        sponsorsContainer('assets/images/IELTS_logo 2.png', () {}),
        sponsorsContainer(
            'assets/images/XFf8KrxwqXo9GY9yDttOPG8rjRjmh1Cd 2.png', () {}),
        sponsorsContainer('assets/images/IELTS_logo 2.png', () {}),
        sponsorsContainer(
            'assets/images/XFf8KrxwqXo9GY9yDttOPG8rjRjmh1Cd 2.png', () {}),
      ],
    );
  }

  Widget sponsorsContainer(String img, Function function) {
    return InkWell(
      onTap: () => function(),
      child: Container(
        height: 70,
        width: 70,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(color: Color(0xFFF6FBFE), boxShadow: [
          BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 3,
              spreadRadius: 1,
              color: Colors.grey)
        ]),
        child: Image.asset(img),
      ),
    );
  }
}
