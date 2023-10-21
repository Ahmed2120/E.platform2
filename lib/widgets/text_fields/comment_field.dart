import 'package:flutter/material.dart';

class CommentField extends StatelessWidget {
  CommentField(
      {super.key,
      required TextEditingController controller,
      required this.function,
        required this.loading

      })
      : _controller = controller;

  final TextEditingController _controller;
  Function function;
  bool loading=false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon:
          loading==true? Padding(
            padding: const EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ):
          IconButton(onPressed: ()=> function(),
            icon: const Icon(Icons.send),),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,
            hintText: 'اضف تعليق',

            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(25)),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(25)),),
      ),
    );
  }
}
