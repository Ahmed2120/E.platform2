import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateIndicator extends StatelessWidget {
   RateIndicator({required this.rate,required this.itemSize,Key? key}) : super(key: key);
   double rate;
   double itemSize;
  @override
  Widget build(BuildContext context) {
    return   RatingBarIndicator(
      rating: rate,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: Colors.yellow,
      ),
      itemCount: 5,
      itemSize: itemSize,
      direction: Axis.horizontal,
    );
  }
}
