import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/school/school.dart';
import 'package:flutter/material.dart';

class NearestSchool extends StatelessWidget {
   NearestSchool({required this.model, Key? key}) : super(key: key);
    MainModel model;

  @override
  Widget build(BuildContext context) {
    final   height= MediaQuery.of(context).size.height;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: model.homeSchoolList.length,
      itemBuilder: (context, index)=> InkWell(
             onTap: ()=> GlobalMethods.navigate(context, SchoolPage(schoolId:model.homeSchoolList[index].Id)),
              child: Column(
        children: [
              Container(
              padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(color: const Color(0xFF000000).withOpacity(0.12)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: model.homeSchoolList[index].Image==''?
               Image.asset(
               'assets/logo/school logo-1.png',
               width: 70,
               height: 70,
             ) :
                 Image.network(
              model.homeSchoolList[index].Image,
              width: 70,
              height: 70,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
                Expanded(
                  child: SizedBox(
                 width: 100,
                  child: Text(
                model.homeSchoolList[index].Name,
                style: TextStyle(fontSize: 13, color: AppColors.titleColor),
                maxLines: 3,
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
