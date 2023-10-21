import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/courses/course.dart';
import '../../model/courses/teacherCourses.dart';
import '../components/custom_card_widget.dart';
import '../components/custom_elevated_button.dart';
import '../courses_and_groups/components/custom_step.dart';
import '../courses_and_groups/videos_page.dart';

class TeacherCoursesPage extends StatefulWidget {
  TeacherCoursesPage({required this.model, required this.teacherId, Key? key})
      : super(key: key);
  MainModel model;
  int teacherId;

  @override
  State<TeacherCoursesPage> createState() => _CourseContentPageState();
}

class _CourseContentPageState extends State<TeacherCoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.model.fetchBranch(widget.course.SubjectId);
    widget.model.fetchTeacherCourses(widget.teacherId, null);
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: ScopedModelDescendant<MainModel>(
          builder: (context, child, MainModel model) {
        return SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                color: AppColors.primaryColor,
              ),
              Container(
                margin: EdgeInsets.only(top: deviceSize.height * 0.08),
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/images/teacher.png')),
                      Text(
                        model.ContentTeacherName.toString(),
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          descriptionContainer(model.ContentSubjectName,
                              'assets/icons/book-description.png'),
                          descriptionContainer(model.ContentGradeName,
                              'assets/icons/level-description.png'),
                          descriptionContainer(
                              'كورسات', 'assets/icons/course-description.png'),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 40,
                        child: widget.model.subLoading == true
                            ? const Center(child: CircularProgressIndicator())
                            : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: model.allBranches.length,
                                itemBuilder: (context, index) =>
                                    subSubjectContainer(
                                        model.allBranches[index]),
                              ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // Expanded(
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: 5,
                      //     itemBuilder: (context, index)=> InkWell(onTap: ()=>
                      //         GlobalMethods.navigate(context, LessonsPage()),
                      //         child: contentContainer()),
                      //   ),
                      // ),
                      widget.model.teacherCourseLoading
                          ? Center(child: CircularProgressIndicator())
                          : Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.allTeacherCourses.length,
                                itemBuilder: (context, index) => CustomCard(
                                  child: ExpansionTile(
                                    title: contentContainer(
                                        model.allTeacherCourses[index]),
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
                                              .allTeacherCourses[index].courseLessons[index1]
                                              .LessonTitle,
                                              subTitle: '${widget
                                              .model
                                              .allTeacherCourses[index]
                                              .courseLessons[index1].VideosCount}فيديو ',
                                               stepNum: index1+1,
                                              price: model
                                              .allTeacherCourses[
                                          index]
                                              .courseLessons[index1]
                                              .Free
                                              ? const Text('مجاني')
                                              : Text(
                                              '${model.allTeacherCourses[index].courseLessons[index1].Price.toString()}'),
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
                                              : const Icon(
                                                 Icons.lock,
                                               color: AppColors
                                                .primaryColor,
                                               ), onTap: () => {

                                            if (model.allTeacherCourses[index]
                                                .IsSubscribed)
                                            {
                                              GlobalMethods.navigate(context, VideosPage(
                                                  model: model,
                                                  courseLessons: model
                                                      .allTeacherCourses[
                                                  index]
                                                      .courseLessons[
                                                  index1])),
                                            }

                                                else if (model.allTeacherCourses[index]
                                                    .courseLessons[index1].Free)
                                                  {
                                                    GlobalMethods.navigate(context, VideosPage(
                                                            model: model,
                                                            courseLessons: model
                                                                    .allTeacherCourses[
                                                                        index]
                                                                    .courseLessons[
                                                                index1])),
                                                  }
                                              },
                                             IsSubscribed:model.allTeacherCourses[index].IsSubscribed ,
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
                                      model.allTeacherCourses[index].IsSubscribed?
                                      Container() :
                                      CustomElevatedButton(title: 'اشترك الان',
                                          function: ()=>
                                              showConfirmDialog(title: 'سيتم خصم ${model.allTeacherCourses[index].Price}'+
                                                ' من محفظتك للاشتراك في كورس ' + model.allTeacherCourses[index].Title ,
                                                  loading: model.subscribeCourse_loading,
                                          onConfirm: ()=> model.subscribeCourse(model.allTeacherCourses[index].CourseId,
                                                  context,index))),
                                      //)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40.0),
                    const Text('كورسات ومجموعات',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            height: 1.5,
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.primaryColor,
                          size: 15,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Step buildStep(Function onTap,
      {String title = '', bool isFree = false, double price = 0}) {
    return Step(
        isActive: true,
        subtitle: Text('3 فيديو'),
        title: InkWell(
          onTap: () => onTap(),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Spacer(),
              isFree ? const Text('مجاني') : Text('$price'),
              isFree
                  ? const Icon(
                      Icons.play_circle,
                      color: AppColors.primaryColor,
                    )
                  : const Icon(
                      Icons.lock,
                      color: AppColors.primaryColor,
                    ),
            ],
          ),
        ),
        content: Container());
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
      Image.asset(
        'assets/images/online-course 1.png',
        width: 40,
        height: 40,
      ),
      const SizedBox(
        width: 6,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${courseContent.Title}',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            '${courseContent.courseLessons.length.toString() + ' دروس '}',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
      const Spacer(),
      Column(
        children: [
          Text(
            courseContent.Price.toString(),
          ),
          Text(courseContent.TotalLessonsPrice.toString(),
              style: TextStyle(decoration: TextDecoration.lineThrough)),
        ],
      ),
    ],
  );
}

Widget unitContainer() {
  return Row(
    children: [
      Image.asset(
        'assets/images/online-course 1.png',
        width: 40,
        height: 40,
      ),
      const SizedBox(
        width: 6,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'الوحدة الاولى',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(
            '4 دروس',
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
      const Spacer(),
      const Text('30 \$'),
    ],
  );
}

Container descriptionContainer(String title, String img) {
  return Container(
    padding: const EdgeInsets.all(3),
    decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10)),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 10, color: AppColors.descriptionColor),
        ),
        const SizedBox(
          width: 5,
        ),
        ImageIcon(AssetImage(img)),
      ],
    ),
  );
}

Widget subSubjectContainer(CustomModel subject) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
        // color: Colors.white
      ),
      child: Center(
          child: Text(
        subject.Name,
        style: const TextStyle(fontSize: 12),
      )),
    );
