import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/videoConference/videoHome_page.dart';
import 'package:flutter/material.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../components/row_title.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  State<LivePage> createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              color: AppColors.primaryColor,
            ),
            Container(
              margin: EdgeInsets.only(top: deviceSize.height * 0.10),
              width: double.infinity,
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20),)
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          buildDateWidget(context),
                          const SizedBox(height: 30,),
                          Stepper(
                            onStepTapped: null,
                            margin: EdgeInsets.zero,
                            steps: getSteps(context),
                            controlsBuilder: (context, controls) {
                              return const SizedBox();
                            },
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                  ],
                ),),
            ),
            CustomRowTitle(title: 'اللايف',),
          ],
        ),
      ),
    );
  }

  Widget buildDateWidget(BuildContext context) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 3),
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

  List<Step> getSteps(context) =>
      [
        buildStep(context, time: 'من 12:00الى 2:00 ظهرا ',
            title: 'الغة العربية مع أ/احمد خالد', onPressed: (){}),
        buildStep(context, time: 'من 4:00 الى 6:00 مساءا',
            title: 'الغة العربية مع أ/احمد خالد', onPressed: (){}),
        buildStep(context, time: 'من 8:00 الى 10:00 مساءا',
            title: 'الغة العربية مع أ/احمد خالد', onPressed: (){}),
      ];

  Step buildStep(context, {String time = '', String title = '', required Function onPressed}) {
    return Step(
        isActive: true,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color(0xFFDEDDFF),
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
              Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: ()=>
                  GlobalMethods.navigate(context,
                  VideoHomePage(),),
                              child: Text('اشترك الان')))
            ],
          ),
        ), content: Container());
  }
}