import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';

class TeacherNotificationPage extends StatelessWidget {
  TeacherNotificationPage({Key? key}) : super(key: key);

  List not = [
    'تم ارسال طلب اضافة لك من محمود حسن',
    'موعد اللايف القادم الساعة 8 صباحا',

  ];

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'الاشعارات',
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: not.length, itemBuilder: (context, index)=> notificationContainer(context, not[index])),
      ),
    );
  }

  Container notificationContainer(context, String title) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Color(0xFFDEDEDE))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(Icons.close),
                      Text('29 june 2021, 9 Am'),
                    ],
                  ),
                  Text(title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
                ],
              ),
            ),
          ),
          const SizedBox(width: 5,),
          Image.asset('assets/images/notification.png'),
        ],
      ),
    );
  }

  Widget profilePhoto(){
    return Stack(
      children: [
        Image.asset('assets/images/student-profile.png'),
        Positioned(child: Image.asset('assets/images/camera.png'), bottom: 0, right: 0,)
      ],
    );
  }

  Widget buildContainer(String txt, Widget? icon, context){
    return SizedBox(
      height: 50,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 40,
            width: double.infinity,
            alignment: icon == null ? Alignment.centerRight : null,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black26),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      blurRadius: 1,
                      spreadRadius: 1
                  )
                ]
            ),
            child: Text(txt, style: Theme.of(context).textTheme.titleMedium,),
          ),
          Positioned(top: 0, left: 5,child: icon?? Container(),)
        ],
      ),
    );
  }


}