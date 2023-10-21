
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/subject/subject.dart';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/courseContent.dart';
import '../../model/courses/course.dart';
import '../../model/courses/teacherCourses.dart';
import '../../model/customModel.dart';
import '../../widgets/custom_stack.dart';
import '../components/custom_card_widget.dart';
import '../components/custom_elevated_button.dart';
import '../courses_and_groups/components/custom_step.dart';
import '../courses_and_groups/coursesAndGroups_page.dart';
import '../courses_and_groups/videos_page.dart';
import 'sub_videos_page.dart';

class SubCourseContentPage extends StatefulWidget {

  SubCourseContentPage({ required this.model,required this.course  ,Key? key}) : super(key: key);
   MainModel model;
  Course course;
  @override
  State<SubCourseContentPage> createState() => _SubCourseContentPageState();
}
class _SubCourseContentPageState extends State<SubCourseContentPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print('nnnnnnnnnnnnnnnnnnnn');
    print(widget.course.TeacherId);
    print(widget.course.TeacherName);
    widget.model.fetchBranch(widget.course.SubjectId);
    widget.model.fetchTeacherCourses(widget.course.TeacherId, widget.course.SubjectId);  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'اشتراكاتي',
        child:
        ScopedModelDescendant<MainModel>(
            builder:(context,child,MainModel model){
              return  Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
               child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius: 30,
                    child: Image.asset('assets/images/teacher.png')),
                Text(model.ContentTeacherName, style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,),
                const SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    descriptionContainer(model.ContentSubjectName, 'assets/icons/book-description.png'),
                    descriptionContainer(model.ContentGradeName, 'assets/icons/level-description.png'),
                    descriptionContainer('كورسات', 'assets/icons/course-description.png'),
                  ],
                ),
                const SizedBox(height: 12,),
                SizedBox(
                  height: 40,
                  child: model.branchLoading == true
                    ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount:  model.allBranches.length,
                    itemBuilder: (context, index)=>
                        subSubjectContainer(model.allBranches[index]),
                  ),
                ),
                const SizedBox(height: 12,),
                CustomCard(
                  child: Row(
                    children: [
                      Image.asset('assets/icons/bookmark.png', width: 40, height: 40,),
                      const SizedBox(width: 6,),
                      const Text('مرجعياتي', style: TextStyle(fontSize: 14, color: Colors.black),),
                    ],
                  ),
                ),
                model.teacherCourseLoading ?
                Center(child: CircularProgressIndicator()):
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model.allTeacherCourses.length,
                    itemBuilder: (context, index)=> CustomCard(
                      child: ExpansionTile(
                        title: contentContainer(model.allTeacherCourses[index]),
                        tilePadding: EdgeInsets.zero,
                        childrenPadding: EdgeInsets.zero,
                        children: [
                          /*   Stepper(
                            onStepTapped: null,
                            margin: EdgeInsets.zero,
                            steps: [

                              buildStep(()=>
                                  GlobalMethods.navigate(context,ScopedModelDescendant<MainModel>(
                                      builder:(context,child,MainModel model){
                                        return  VideosPage(model:model ,
                                            courseVideo:widget.model.allCourseContent[index]
                                                .CourseVideos[0]); })
                                  ),
                                  title:'الدرس الاول', isFree: true), buildStep(()=>
                                  GlobalMethods.navigate(context,ScopedModelDescendant<MainModel>(
                                      builder:(context,child,MainModel model){
                                        return   VideosPage(model:model,
                                            courseVideo:widget.model.allCourseVideoDetails[0]); })
                                  ),
                                  title:'الدرس الثاني', isFree: true),
                              buildStep((){}, title:'الدرس الثالث', price: 25),
                              buildStep((){}, title:'الدرس الرابع', price: 40),
                            ],
                            controlsBuilder: (context, controls) {
                              return const SizedBox();
                            },
                          ) */
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: model
                                  .allTeacherCourses[index]
                                  .courseLessons
                                  .length,
                              itemBuilder: (context, index1) =>
                                  CustomStep(
                                title: widget
                                    .model
                                    .allTeacherCourses[
                                index]
                                    .courseLessons[
                                index1]
                                    .LessonTitle,
                                subTitle: '${widget
                                    .model
                                    .allTeacherCourses[
                                index]
                                    .courseLessons[
                                index1]
                                    .VideosCount}فيديو ',
                                stepNum: index1+1,
                                price: model
                                    .allTeacherCourses[
                                index]
                                    .courseLessons[index1]
                                    .Free
                                    ? const Text('مجاني')
                                    : Text(
                                    GlobalMethods.showPrice(model.allTeacherCourses[index].
                                    courseLessons[index1].Price)),
                                icon: model
                                    .allTeacherCourses[
                                index]
                                    .courseLessons[index1]
                                    .Free
                                    ? const Icon(
                                   Icons.play_circle,
                                   color: AppColors
                                      .primaryColor,
                                    )
                                    :  Icon(
                                    Icons.lock,
                                  color: AppColors
                                      .primaryColor,
                                   ), onTap: () => {

                                    if (model.allTeacherCourses[index].IsSubscribed)
                                      {

                                        GlobalMethods.navigate(
                                            context, VideosPage(
                                                model: model, courseLessons: model.allTeacherCourses[index]
                                                    .courseLessons[index1])),

                                      }
                                    else if (model.allTeacherCourses[index]
                                        .courseLessons[index1].Free)
                                      {
                                        GlobalMethods.navigate(
                                            context,
                                            VideosPage(
                                                model: model,
                                                courseLessons: model.allTeacherCourses[index]
                                                    .courseLessons[index1])),
                                      },
                              },
                                                IsSubscribed: true,
                                      IsLessonSubscribed:model.allTeacherCourses[index].courseLessons[index1].IsSubscribed
                              )

                            /* ExpansionTile(
                                title: unitContainer(),
                                tilePadding: EdgeInsets.zero,
                                childrenPadding: EdgeInsets.zero,
                                children: [
                                 /* Stepper(
                                    onStepTapped: null,
                                    margin: EdgeInsets.zero,
                                    steps: [
                                      buildStep(()=>
                                   GlobalMethods.navigate(context,ScopedModelDescendant<MainModel>(
                                    builder:(context,child,MainModel model){
                                     return  VideosPage(model:model ,
                                         courseVideo:widget.model.allCourseVideoDetails[0]); })

                                           ),
                                          title:'الدرس الاول', isFree: true), buildStep(()=>
                                    GlobalMethods.navigate(context,ScopedModelDescendant<MainModel>(
                                          builder:(context,child,MainModel model){
                                       return   VideosPage(model:model,
                                           courseVideo:widget.model.allCourseVideoDetails[0]); })
                                          ),
                                          title:'الدرس الثاني', isFree: true),
                                      buildStep((){}, title:'الدرس الثالث', price: 25),
                                      buildStep((){}, title:'الدرس الرابع', price: 40),
                                    ],
                                    controlsBuilder: (context, controls) {
                                      return const SizedBox();
                                    },
                                  )*/

                                ],
                              ), */
                          ),

                          //)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              ),); })
    )
    );

  }


  Step buildStep(Function onTap,{String title = '' }) {
    return Step(
        isActive: true,
        subtitle: Text('3 فيديو'),
        title: InkWell(
          onTap: ()=> onTap(),
          child: Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium,),
              const Spacer(),
              const Icon(Icons.play_circle, color: AppColors.primaryColor,),
            ],
          ),
        ), content: Container());
  }
  void showConfirmDialog({required String title, required Function onConfirm, required bool loading}){
    showDialog(context: context, barrierDismissible: false, builder: (context)=>
        AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: ()=> Navigator.pop(context),
                    child: const Icon(Icons.close, size: 40, color: Colors.black,)),
                Text('', style: Theme.of(context).textTheme.titleMedium,),
                const SizedBox(width: 40,)
              ],),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    loading ? const CircularProgressIndicator() :
                    CustomElevatedButton(title: 'تأكيد', function: ()=>onConfirm()),
                    CustomElevatedButton(title: 'الغاء',
                      function: ()=> Navigator.pop(context),
                      color: AppColors.cancelColor,),
                  ],
                )
              ],
            )
        ));
  }

}


Widget contentContainer(TeacherCourses courseContent) {
  return Row(
    children: [
      Image.asset('assets/images/online-course 1.png', width: 40, height: 40,),
      const SizedBox(width: 6,),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text('${courseContent.Title}', style: TextStyle(fontSize: 14, color: Colors.black),),
          Text('${courseContent.LessonsCount.toString()+ ' دروس '}',
            style: TextStyle(fontSize: 14, color: Colors.black),),
        ],
      ),
      const Spacer(),
      Text(courseContent.Price.toString()),

    ],
  );
}


Widget unitContainer() {
    return Row(
      children: [
        Image.asset('assets/images/online-course 1.png', width: 40, height: 40,),
        const SizedBox(width: 6,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('الوحدة الاولى', style: TextStyle(fontSize: 14, color: Colors.black),),
            Text('4 دروس', style: TextStyle(fontSize: 14, color: Colors.black),),
          ],
        ),
      ],
    );
  }

  Container descriptionContainer(String title, String img) {
    return Container(
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
                );
  }


Widget subSubjectContainer(CustomModel  branch) => Container(

  padding: const EdgeInsets.symmetric(horizontal: 20),
  margin: const EdgeInsets.only(right: 10),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(color: AppColors.primaryColor),
    // color: Colors.white
  ),

  child:  Center(child: Text(branch.Name, style: const TextStyle(fontSize: 12),)),

);


  Widget courseContainer(context) => Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/teacher.png', width: 50, height: 50,),
        const Text('كورس أ/ عاطف محمود', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),),
        const Text('لغة عربية ', style: TextStyle(color: Color(0xFF888B8E)),),
        ElevatedButton(onPressed: (){}, child: const Text('اشترك الان'))
      ],
    ),
  );