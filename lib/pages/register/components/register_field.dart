import 'package:flutter/material.dart';

class RegisterField extends StatelessWidget {
  RegisterField(
      {super.key,
      required TextEditingController controller,
      required this.hintText,
      this.isPassword = false,
      this.changePassword = false,
      this.required = true,
        this.togglePass,
      this.passwordTxt = ''})
      : _controller = controller;

  final TextEditingController _controller;
  String hintText;
  bool isPassword;
  bool changePassword;
  bool required;
  Function? togglePass;
  String passwordTxt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        obscureText: changePassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            suffixIcon: isPassword ? IconButton(onPressed: ()=>togglePass!(), icon: changePassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)) : null,

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
                borderRadius: BorderRadius.circular(10))
        ),
        validator: (val) {
          if (required && _controller.text.isEmpty) {
            return 'الرجاء كتابة $hintText';
          }
          if ( isPassword && _controller.text.length<8) {
            return 'كلمة المرور يجب الا تقل عن 8 احرف';
          }
          if ( isPassword &&
              !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(_controller.text)) {
            return 'يجب ان تحتوي كلمة المرور على ارقام واحرف ورموز';
          }
        },
      ),
    );
  }
}
