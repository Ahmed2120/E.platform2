import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

class CustomStep extends StatelessWidget {
  const CustomStep({Key? key,
    required this.title,
    required this.subTitle,
    required this.stepNum, required this.onTap, required this.icon, required this.price,
      required this.IsSubscribed,required this.IsLessonSubscribed}) : super(key: key);

  final String title;
  final String subTitle;
  final int stepNum;
  final Function onTap;
  final Widget icon;
  final Widget price;
  final bool IsSubscribed;
  final bool IsLessonSubscribed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title, style: Theme.of(context).textTheme.titleMedium,),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall,),
      leading: Chip(
        shape: CircleBorder(),
        label: Text('$stepNum'), backgroundColor: AppColors.primaryColor,
                       labelStyle: const TextStyle(color: Colors.white),),
               trailing:
                      !IsLessonSubscribed?
                       SizedBox(
                        width: 90,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            price,
                            icon,
                          ],
                        ),
                      )
                      : Container(width: 1,),
      onTap: ()=> onTap(),
    );
  }
}
