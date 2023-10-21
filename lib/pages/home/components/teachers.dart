import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:flutter/material.dart';

import '../../../core/utility/global_methods.dart';
import '../../../widgets/rateIndecator.dart';
import '../../teachers/teacher_content.dart';

class Teachers extends StatelessWidget {
  Teachers({required this.model, Key? key}) : super(key: key);
  MainModel model;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: model.allTeachers.length,
        itemBuilder: (context, index) => InkWell(
              onTap: () => GlobalMethods.navigate(
                  context,
                  TeacherContentPage(
                      model: model, teacher: model.allTeachers[index])),
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  border: Border.all(
                      color: const Color(0xFF000000).withOpacity(0.12)),
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
                    Text(
                      model.allTeachers[index].Name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      model.allTeachers[index].Subjects,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      maxLines: 1,
                    ),
                    RateIndicator(
                        rate: model.allTeachers[index].Rate, itemSize: 25),
                  ],
                ),
              ),
              //    child: Stack(
              //      alignment: Alignment.center,
              //      children: [
              //     Container(
              //       height: 130,
              //       padding: const EdgeInsets.all(10),
              //       margin: const EdgeInsets.symmetric(horizontal: 10),
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //         border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey.withOpacity(0.5),
              //             blurRadius: 1,
              //             offset: const Offset(0, 3), // changes position of shadow
              //           ),
              //         ],
              //       ),
              //       child: Column(
              //         children: [
              //           SizedBox(height: 6,),
              //           Text(model.allTeachers[index].Name,
              //             style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              //           maxLines: 1,),
              //           SizedBox(height: 6,),
              //           Text(model.allTeachers[index].Subjects, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),maxLines: 1,),
              //           RateIndicator(rate:model.allTeachers[index].Rate , itemSize:25),
              //         ],
              //       ),
              //     ),
              //     Positioned(top: 0, child: Image.asset('assets/images/english.png')),
              //   ],
              // ),
            ));
  }
}
