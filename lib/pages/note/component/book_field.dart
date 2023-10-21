import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';

class bookField extends StatelessWidget {
  bookField(
      {super.key,
        required TextEditingController controller,
        required this.hintText})
      : _controller = controller;

  final TextEditingController _controller;
  String hintText;


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 1,
            spreadRadius: 2,
            offset: const Offset(
                1, 1), // changes position of shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: _controller,
        style: const TextStyle(color: AppColors.primaryColor),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
