import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  LoginField(
      {
      required TextEditingController controller,
      this.isPassword = false,
      this.showPassword = false,
        this.togglePass,
        this.txt

      })
      : _controller = controller;

  final TextEditingController _controller;
  bool isPassword;
  bool showPassword;
  Function? togglePass;
  String ? txt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        obscureText: showPassword,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: isPassword ? 'كلمة المرور' : 'رقم الهاتف',
            suffixIcon: isPassword ? IconButton(onPressed: ()=>togglePass!(), icon: showPassword ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)) : null,

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
            return isPassword ? 'please type password' : 'please type username';
          }
        },
      ),
    );
  }
}
