import 'package:flutter/material.dart';

class ConfirmPassField extends StatelessWidget {
  ConfirmPassField(
      {super.key,
      required TextEditingController controller,
      required this.hintText,
      required this.togglePass,
        this.passwordController,
      this.isConfirmPassword = false,})
      : _controller = controller;

  final TextEditingController _controller;
  TextEditingController? passwordController;
  String hintText;
  bool isConfirmPassword;
  Function togglePass;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        obscureText: isConfirmPassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            suffixIcon: IconButton(onPressed: ()=>togglePass(), icon: isConfirmPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)),

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
          if (_controller.text.isEmpty) {
            return 'الرجاء كتابة $hintText';
          }
          if ( isConfirmPassword && _controller.text != passwordController!.text) {
            return 'لا تتطابق مع كلمة المرور';
          }
        },
      ),
    );
  }
}
