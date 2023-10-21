import 'package:flutter/material.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({Key? key, required this.title, required this.onSelectDate}) : super(key: key);

  final String title;
  final Function onSelectDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                blurRadius: 3
            )
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme
              .of(context)
              .textTheme
              .titleMedium, textAlign: TextAlign.center,),
          IconButton(onPressed: ()=>onSelectDate(), icon: Icon(Icons.date_range))
        ],
      ),
    );
  }
}
