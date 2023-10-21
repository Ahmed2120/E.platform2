import 'package:flutter/material.dart';

class MsgField extends StatelessWidget {
  MsgField(
      {super.key,
        required this.MsgLoading,
      required TextEditingController controller,
      required this.function,

      })
      : _controller = controller;

  final TextEditingController _controller;
  Function function;
  bool MsgLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        minLines: 1,
        maxLines: 5,
        controller: _controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          suffixIcon:
          MsgLoading ?Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ):
          IconButton(onPressed: ()=> function(), icon: const Icon(Icons.send),),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            filled: true,
            fillColor: Colors.white,

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
