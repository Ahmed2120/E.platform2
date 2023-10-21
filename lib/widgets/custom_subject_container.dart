import 'package:flutter/material.dart';

import '../model/customModel.dart';

class CustomSubjectContainer extends StatelessWidget {
  const CustomSubjectContainer({Key? key, required this.sub}) : super(key: key);

  final CustomModel sub;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFBBDDF8),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset('assets/icons/arabic_book.png', width: 40, height: 40,),
        ),
        Text(sub.Name, style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,)
      ],
    );
  }
}
