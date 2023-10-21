import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/pages/components/row_title.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../widgets/custom_stack.dart';


class TeacherSchedulePage extends StatefulWidget {
  const TeacherSchedulePage({Key? key}) : super(key: key);

  @override
  State<TeacherSchedulePage> createState() => _TeacherSchedulePageState();
}

class _TeacherSchedulePageState extends State<TeacherSchedulePage> {

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'الجدول',
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  buildDateWidget(context),
                  const SizedBox(height: 30,),
                  Expanded(
                    child:  ListView.builder(
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) =>
                          buildStep(context, time: 'من 12:00الى 2:00 ظهرا ',
                              title: 'لغة عربية مجموعة ج ',
                              stepNum: index+1)
                      ,

                    ),
                  ),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStep(context, {String time = '', String title = '', required int stepNum}) {
    return Row(
      children: [
        Chip(
          shape: CircleBorder(),
          label: Text('$stepNum'), backgroundColor: AppColors.primaryColor, labelStyle: const TextStyle(color: Colors.white),),

        Expanded(
          child: Container(
            // width: double.infinity,
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF3DB2FF).withOpacity(0.18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                Text(time, style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,),
                const SizedBox(height: 10,),
                Text(title, style: Theme
                    .of(context)
                    .textTheme
                    .bodySmall,),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildDateWidget(BuildContext context) =>
      Container(
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
            Text(' جدول ${GlobalMethods().dateFormat(_dateTime)}', style: Theme
                .of(context)
                .textTheme
                .titleMedium, textAlign: TextAlign.center,),
            IconButton(onPressed: () {
              showDatePicker(
                  context: context,
                  initialDate: _dateTime,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(DateTime
                      .now()
                      .year + 1)).then((value) {
                setState(() { if(value != null) _dateTime = value;}
                );
              });
            }, icon: Icon(Icons.date_range))
          ],
        ),
      );
}