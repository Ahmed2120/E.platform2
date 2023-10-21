import 'package:flutter/material.dart';

class CreateCourseField extends StatelessWidget {
  CreateCourseField(
      {super.key,
        required TextEditingController controller,
        required this.hintText,
      })
      : _controller = controller;

  final TextEditingController _controller;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10))
        ),
        validator: (val) {
          if (_controller.text.isEmpty) {
            return 'الرجاء كتابة $hintText';
          }
         },
      ),
    );
  }
}
