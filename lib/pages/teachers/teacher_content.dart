import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/widgets/dialogs/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/teacher/teacher.dart';
import '../../widgets/description_container.dart';
import '../../widgets/rateIndecator.dart';
import '../components/row_title.dart';
import 'teacher_courses_page.dart';
import 'teacher_groups_page.dart';

class TeacherContentPage extends StatelessWidget {
  TeacherContentPage({required this.model,required this.teacher ,Key? key}) : super(key: key);
   MainModel model;
    Teachers teacher;
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
     model.fetchTeacherDetails(teacher.Id);
    final deviceSize = MediaQuery.of(context).size;

    return ScopedModelDescendant<MainModel>(
           builder:(context,child,MainModel model){
        return Scaffold(
          body: SafeArea(
             child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  color: AppColors.primaryColor,
                ),
                Container(
                  margin: EdgeInsets.only(top: deviceSize.height * 0.08),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
                  ),
                  child: Padding(padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                    child: model.allTecherDetailsLoading?
                        const Center(child: CircularProgressIndicator())
                         : Column(
                           children: [
                           CircleAvatar(radius: 40,
                            child:model.teacherDetailsProfilePicture==''?
                            Image.asset('assets/images/teacher.png'):
                            Image.network(model.teacherDetailsProfilePicture )
                        ),
                           Text(model.teacherDetailsName,
                           style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                          Center(child: RateIndicator(rate: model.teacherDetailsRate,itemSize:35)),
                          Text(model.teacherDetailsFollowersCount.toString()+' متابع',
                          style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
                          Text(model.teacherDetailsReviewersCount.toString()+' من المقيمين',
                          style: Theme.of(context).textTheme.titleSmall, textAlign: TextAlign.center,),
                          const SizedBox(height: 12,),
                          Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          runAlignment: WrapAlignment.center,
                          alignment: WrapAlignment.center,
                          children: [
                            DescriptionContainer(title: model.teacherDetailsSubjects,
                                img: 'assets/icons/book-description.png'),
                            DescriptionContainer(title: model.teacherDetailsGrades,
                                img: 'assets/icons/level-description.png'),
                            const DescriptionContainer(title: 'المنهج الكويتي', img: 'assets/icons/level-description.png'),
                            const DescriptionContainer(title: 'لغات', img: 'assets/icons/level-description.png'),
                            const DescriptionContainer(title: 'المنهج المصري', img: 'assets/icons/level-description.png'),
                            DescriptionContainer(title: model.teacherDetailsEducationTypes,
                                img: 'assets/icons/level-description.png'),
                          ],
                        ),
                          const SizedBox(height: 12,),
                             Expanded(
                              child: ListView(
                              shrinkWrap: true,
                              children: [
                                InkWell(onTap: ()=> GlobalMethods.navigate(context, TeacherCoursesPage(model: model, teacherId: teacher.Id,)),
                                    child: contentContainer(context,
                                        img: 'assets/images/video-marketing (1) 6.png',
                                        title: 'عدد الكورسات',
                                        subtitle: model.teacherDetailsCoursesCount.toString()+' كورس')),
                                InkWell(onTap: ()=> GlobalMethods.navigate(context,
                                    TeacherGroupsPage(model: model, teacherId: teacher.Id,)),
                                    child: contentContainer(context, img:
                                    'assets/icons/people.png', title: 'عدد المجموعات',
                                        subtitle:model.teacherDetailsGroupsCount.toString() +' مجموعات')),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildContainer(context, deviceSize.width,
                                        img: 'assets/images/exam.png',
                                        title: 'ساعات العمل',
                                        subtitle: model.teacherDetailsWorkingHours.toString()+' ساعة'),
                                    buildContainer(context,deviceSize.width, img: 'assets/icons/people.png',
                                        title: 'عدد المشتركين',
                                        subtitle:model.teacherDetailsSubscribersCount.toString() +' مشترك')
                                  ],)
                              ]
                          ),
                        )
                      ],
                    ),),
                ),

                 Positioned(
                  top: deviceSize.height * 0.1,
                  left: 20,
                  child: InkWell(onTap: (){
                    ShowMyDialog.showMsg('تم ارسال طلب اضافة ');
                  },
                    child: Image.asset('assets/images/add-friend 1.png'),),
                ),
                 Positioned(
                  top: deviceSize.height * 0.1,
                  right: 20,
                  child: InkWell(onTap: (){},
                    child: const Icon(Icons.info, color: AppColors.primaryColor, size: 40,),),
                ),

                const CustomRowTitle(title: 'المدرسين',),

              ],
            ),
          ),
        );
      }
    );
  }

  Container contentContainer(context, {required String img, required String title, required String subtitle, }) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        border: const Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(img, width: 40, height: 40,),
          const SizedBox(width: 6,),
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium,),
              Text(subtitle, style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,),
          ),
        ],
      ),
    );
  }

  Container buildContainer(context, w,
      {required String img, required String title, required String subtitle, }) {
    return Container(
      padding: const EdgeInsets.only(top: 15,bottom: 15,left: 3,right: 3),
      width: w*(0.45),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 2),
      decoration: BoxDecoration(
        border: const Border(right: BorderSide(color: AppColors.primaryColor, width: 5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(img, width: 40, height: 40,fit: BoxFit.fill,),
          const SizedBox(width: 3,),
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium,maxLines: 2, ),
              Text(subtitle, style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
        ],
      ),
    );
  }

  Widget descriptionContainer(String title, String img) {
    return UnconstrainedBox(
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),),
            const SizedBox(width: 5,),
            ImageIcon(AssetImage(img)),
          ],
        ),
      ),
    );
  }
}

class SubSubject{
  final int id;
  final int subjectId;
  final String name;
  bool isActive;

  SubSubject(this.id, this.name, this.subjectId, {this.isActive = false});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is SubSubject && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}