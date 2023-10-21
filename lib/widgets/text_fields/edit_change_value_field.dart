import 'package:flutter/material.dart';

class EditChangeValueField extends StatelessWidget {
  EditChangeValueField(
      {super.key,
        required this.hintText,
        required this.onChange,
         required this.value
      });

  String hintText;
  Function onChange;
  String value;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      textAlign: TextAlign.right,
      keyboardType: TextInputType.number,
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
            borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: (value)=> onChange(value),
    );
  }
}
