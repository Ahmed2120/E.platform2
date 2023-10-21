import 'package:flutter/material.dart';


class PagesBackground extends StatelessWidget {
  const PagesBackground({Key? key, required this.child, required this.title}) : super(key: key);

  final Widget child;
  final String title;

  @override
  Widget build(BuildContext context) {

    final dSize = MediaQuery.of(context).size;

    return Container(
      height: dSize.height,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF44A08D), Color(0xFF093637)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('kkk'),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15), )
              ),
              child: child,
            ),
          ),

        ],
      ),
    );
  }
}
