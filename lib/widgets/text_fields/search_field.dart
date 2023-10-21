import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  SearchField({Key? key, required this.onChange, required this.hintText}) : super(key: key);

  final String hintText;
  final Function onChange;
  bool hasTxt = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              spreadRadius: 3
          )
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          prefixIcon:  const Icon(Icons.search, size: 25,),

        ),
        onChanged: (val){
          onChange(val);

          if(val.isNotEmpty){
            hasTxt = true;
          }else{
            hasTxt = false;
          }
          },
      ),
    );
  }
}
