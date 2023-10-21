import 'package:cached_network_image/cached_network_image.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/app_colors.dart';
import '../../../core/utility/global_methods.dart';
import '../../../pages/components/custom_elevated_button.dart';
import '../../../widgets/dialogs/delete_dialog.dart';
import 'create_live_page.dart';
import 'dit_live_page.dart';

class TeacherLivePage extends StatefulWidget {
  const TeacherLivePage({Key? key}) : super(key: key);

  @override
  State<TeacherLivePage> createState() => _TeacherLivePageState();
}

class _TeacherLivePageState extends State<TeacherLivePage> {

  List liv = [
    'لديك حصة لايف الساعة 12',
    'لديك حصة لايف الساعة 4',
  ];

  DateTime _dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'اللايف',
        child: Column(
          children: [
            buildDateWidget(context),
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: liv.length,
                itemBuilder: (BuildContext context, int index) =>
                    Dismissible(
                      key: Key(index.toString()),
                      background: Container(
                        color: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.only(left: 16),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.grey,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        margin: const EdgeInsets.only(left: 16),
                        alignment: Alignment.centerLeft,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      confirmDismiss: (direction) async {
                        if(direction == DismissDirection.startToEnd) {
                          showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => DeleteDialog(
                                  title: 'هل تريد الحذف ؟',
                                  onConfirm: () {},
                                  loading: false)).then((value) {
                            if(value !=null && value) {
                              // TODO : REMOVE ITEM
                              return true;
                            }});}
                        else {
                          GlobalMethods.navigate(context, EditLivePage());
                          return false;
                        }
                      },
                      child: buildSteps(context, time: 'من 12 الى 4',
                          title: liv[index],
                          stepNum: index+1),
                    )
                ,
              )
            ),
            const SizedBox(height: 15,),
            CustomElevatedButton(title: 'انشاء', function: ()=>GlobalMethods.navigate(context, CreateLivePage())),
            const SizedBox(height: 10,),
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
            title: 'لديك حصة لايف السعة124', onPressed: (){}),
        buildStep(context, time: 'من 4:00 الى 6:00 مساءا',
            title: 'لديك حصة لايف الساعة 4', onPressed: (){}),
        buildStep(context, time: 'من 8:00 الى 10:00 مساءا',
            title: 'لديك حصة لايف الساعة 8', onPressed: (){}),
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
              Align(alignment: Alignment.centerLeft, child: TextButton(onPressed: ()=>onPressed(), child: Text('اشترك الان')))
            ],
          ),
        ), content: Container());
  }

  Widget buildSteps(context, {String time = '', String title = '', required int stepNum}) {
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
}