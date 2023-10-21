import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/rateIndecator.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/global_methods.dart';
import '../../subscribtions/sub_course_content_page.dart';

class MySubscriptions extends StatelessWidget {
  MySubscriptions({required this.model, Key? key}) : super(key: key);
  MainModel model;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: model.StudentSubscriptionsCoursesList.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          GlobalMethods.navigate(
              context,
              SubCourseContentPage(
                  model: model, course: model.StudentSubscriptionsCoursesList[index]));
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border:
                Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 1,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/english.png'),
              SizedBox(
                height: 4,
              ),
              Expanded(
                  child: Text(
                'كورس ' +
                    model.StudentSubscriptionsCoursesList[index].SubjectName
                        .toString(),
                style: TextStyle(
                    fontSize: deviceSize.height * 0.02,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                maxLines: 1,
              )),
              SizedBox(
                height: 6,
              ),
              Text(
                  model.StudentSubscriptionsCoursesList[index].TeacherName
                      .toString(),
                  style: TextStyle(
                      fontSize: deviceSize.height * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    // child: Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Container(
    //       height: 130,
    //       padding: const EdgeInsets.all(10),
    //       margin: const EdgeInsets.symmetric(horizontal: 10),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.circular(10),
    //         color: Colors.white,
    //         border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
    //         boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.5),
    //           blurRadius: 1,
    //           offset: const Offset(0, 3), // changes position of shadow
    //         ),
    //       ],
    //       ),
    //       child: Column(
    //         children: [
    //           SizedBox(height: 6,),
    //           Expanded(
    //               child: Text('كورس '+
    //                   model.StudentSubscriptionsCoursesList[index].SubjectName.toString(),
    //             style: TextStyle(fontSize: deviceSize.height * 0.02,
    //                 fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1,)),
    //           SizedBox(height: 6,),
    //           Text(model.StudentSubscriptionsCoursesList[index].TeacherName.toString(), style: TextStyle(fontSize: deviceSize.height * 0.02, fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1),
    //           Row(
    //             children: [
    //               Icon(Icons.star, color: Colors.yellow,),
    //               Icon(Icons.star, color: Colors.yellow,),
    //               Icon(Icons.star, color: Colors.yellow,),
    //             ],
    //           )
    //         ],
    //       ),
    //     ),
    //     Positioned(top: 0, child: Image.asset('assets/images/english.png')),
    //   ],
    // ),
    //));
  }
}
