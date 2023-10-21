import 'package:eplatform/model/subject/subject.dart';
import 'package:flutter/material.dart';

class CustomSubjectWidget extends StatelessWidget {
  const CustomSubjectWidget(
      {super.key,
      required this.subject,
      required this.onTap,
      required this.isActive});

  final Subject subject;
  final VoidCallback onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFBBDDF8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/arabic_book.png',
              width: 40,
              height: 40,
            ),
          ),
          Text(
            subject.Name,
            style: isActive
                ? Theme.of(context).textTheme.bodyMedium
                : Theme.of(context).textTheme.titleSmall,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
