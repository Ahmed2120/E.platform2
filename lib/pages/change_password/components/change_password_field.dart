import 'package:flutter/material.dart';

class ChangePasswordField extends StatelessWidget {
  ChangePasswordField(
      {super.key,
        required TextEditingController controller,
        this.passwordController,
        required this.hintText,
        this.hidePassword = true,
        this.isConfirmPassword = false})
      : _controller = controller;

  final TextEditingController _controller;
  TextEditingController? passwordController;
  String hintText;
  bool isConfirmPassword;
  bool hidePassword;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        obscureText: hidePassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            prefixIcon: hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.white,
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
                borderRadius: BorderRadius.circular(15))),
        validator: (val) {
          if (_controller.text.isEmpty) {
            return 'الرجاء كتابة $hintText';
          }
          if ( isConfirmPassword && _controller.text != passwordController!.text) {
            return 'لا تتطابق مع كلمة المرور';
          }
          if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(_controller.text)) {
            return 'يجب ان تحتوي كلمة المرور على ارقام واحرف ورموز';
          }
        },
      ),
    );
  }
}
