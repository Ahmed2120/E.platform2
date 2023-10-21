import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScheduleParentPage extends StatefulWidget {
  const ScheduleParentPage({Key? key, required this.model}) : super(key: key);

  final MainModel model;

  @override
  State<ScheduleParentPage> createState() => _ScheduleParentPageState();
}

class _ScheduleParentPageState extends State<ScheduleParentPage> {
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    widget.model
        .fetchSchedule(GlobalMethods().scheduleDateFormat(DateTime.now()));
  }

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
                  const SizedBox(
                    height: 30,
                  ),
                  Expanded(
                    child: ScopedModelDescendant(
                        builder: (context, child, MainModel model) {
                      return model.scheduleLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.builder(
                              itemCount: model.scheduleList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  buildStep(context,
                                      time:
                                          'من ${GlobalMethods().formatTimeFromString(model.scheduleList[index].FromTime)}الى ${GlobalMethods().formatTimeFromString(model.scheduleList[index].ToTime)} ',
                                      title:
                                          '${model.scheduleList[index].SubjectName} مع ${model.scheduleList[index].TeacherName}',
                                      stepNum: index + 1),
                            );
                    }),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateWidget(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 3)]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' جدول ${GlobalMethods().dateFormat(_dateTime)}',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            IconButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate: _dateTime,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1))
                      .then((value) {
                    setState(() {
                      if (value != null) _dateTime = value;
                      widget.model.fetchSchedule(
                          GlobalMethods().scheduleDateFormat(_dateTime));
                    });
                  });
                },
                icon: Icon(Icons.date_range))
          ],
        ),
      );

  Widget buildStep(context,
      {String time = '', String title = '', required int stepNum}) {
    return Row(
      children: [
        Chip(
          shape: CircleBorder(),
          label: Text('$stepNum'),
          backgroundColor: AppColors.primaryColor,
          labelStyle: const TextStyle(color: Colors.white),
        ),
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
                Text(
                  time,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContainer(context, {String time = '', String title = ''}) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xFF3DB2FF).withOpacity(0.18),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Text(
              time,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      );
}
