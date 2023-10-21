import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/teacherModels/teacherCourseForAll.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/create_course/create_courseLesson_page.dart';
import 'package:eplatform/teacher/pages/create_course/create_course_page.dart';
import 'package:eplatform/teacher/pages/teacher_courses/teacherCourseLessonvideos_page.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../core/utility/app_colors.dart';
import '../../../pages/components/custom_card_widget.dart';
import '../../../pages/courses_and_groups/components/custom_step.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../teacher_create_exam/teacher_create_exam.dart';
import 'edit_lesson_page.dart';
import '../../../widgets/dialogs/delete_dialog.dart';
import 'edit_course_page.dart';

class CoursesManagementPage extends StatefulWidget {
  CoursesManagementPage({ required this.model, Key? key}) : super(key: key);
  MainModel model;

  @override
  State<CoursesManagementPage> createState() => _CoursesManagementPageState();
}

class _CoursesManagementPageState extends State<CoursesManagementPage> {

  CustomModel? teacher;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  int ? _selectedSubectId;

          @override
      void initState() {
     // TODO: implement initState
            widget.model.fetchTeacherEducationType();
            widget.model.fetchTeacherEducationLevels();

          }

  @override
  Widget build(BuildContext context) {
        widget.model.fetchAllTeacherCreatedCourses(
            _selectedSubectId,
            educationType==null?null: educationType!.Id,
            educationLevel==null?null :educationLevel!.Id,
            curriculumType==null?null: curriculumType!.Id
    );
    final deviceSize = MediaQuery.of(context).size;

    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
            body: CustomStack(
            pageTitle: 'الكورسات',
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                        Expanded(child:  model.customEducationType?
                        const Center(child: CircularProgressIndicator()):
                        CustomDropDown(model.allCustomEducationType,
                        changeEducationType, educationType, 'نوع التعليم'),),
                         const SizedBox(width: 8,),

                     Expanded(child: model.customEducationProgramsLoading?const Center(child: CircularProgressIndicator()):
                      CustomDropDown(model.allCustomEducationPrograms,
                        change_educationPrograms, curriculumType, 'نوع المنهج'),),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                model.customLevel_loading ?const Center(child: CircularProgressIndicator()):
                CustomDropDown(model.allCustomEducationLevels, selectLevel, educationLevel, 'السنة الدراسية'),
                const SizedBox(height: 10,),
                Container(
                  height: 130,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.allTeacherSubjects.length,
                    itemBuilder: (context, index)=>
                        InkWell(
                            onTap: (){
                              _selectedSubectId=model.allTeacherSubjects[index].Id;
                              setState(() {

                              });
                            },
                            child: subjectContainer(context,model.allTeacherSubjects[index])),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child:model.showAllTeacherCreatedCourseLoading?
                      const Center(child: CircularProgressIndicator()):
                      model.allTeacherCreatedCourses.length>0?
                      ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.allTeacherCreatedCourses.length,
                      itemBuilder: (context, index) =>
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
                                if(!UserSession.hasPrivilege(3)) {
                                        ShowMyDialog.showMsg(
                                            'You do not have the authority');
                                        return false;
                                      }
                                      showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => DeleteDialog(
                                        title: 'هل تريد حذف كورس _ ${model.allTeacherCreatedCourses[index].Title}؟',
                                        onConfirm: () {
                                       //  model.deleteTeacherCreatedCourse(model.allTeacherCreatedCourses[index].CourseId, index);
                                        },
                                        loading: false)).then((value) {
                                  if(value !=null && value) {
                                    // TODO : REMOVE ITEM
                                    return true;
                                  }});}
                              else {
                                if(!UserSession.hasPrivilege(2)) {
                                  ShowMyDialog.showMsg(
                                      'You do not have the authority');
                                  return false;
                                }
                                  GlobalMethods.navigate(context,
                                    EditCoursePage(model: model,
                                      courseId: model.allTeacherCreatedCourses[index].CourseId,));
                                return false;
                              }
                             },
                            child: CustomCard(
                              child: ExpansionTile(
                                title: courseContainer(context,model.allTeacherCreatedCourses[index]),
                                tilePadding: EdgeInsets.zero,
                                childrenPadding: EdgeInsets.zero,
                                children: [
                                  ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: model.allTeacherCreatedCourses[index].CourseLessonDetails.length ,
                                      itemBuilder: (context, index1) =>
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
                                                        title: 'هل تريد حذف درس _ ${model.allTeacherCreatedCourses[index].CourseLessonDetails[index1]
                                                            .LessonTitle}؟',
                                                        onConfirm: () {
                                                   model.deleteTeacherCreatedCourseLesson(model.allTeacherCreatedCourses[index].
                                                                   CourseLessonDetails[index1].LessonId,index, index1);
                                                        },
                                                        loading: false)).then((value) {
                                                  if(value !=null && value) {
                                                    // TODO : REMOVE ITEM
                                                    return true;
                                                  }});}
                                              else {
                                                GlobalMethods.navigate(context, EditLessonPage(courseLessonId: model.allTeacherCreatedCourses[index]
                                                    .CourseLessonDetails[index1].LessonId, courseId: model.allTeacherCreatedCourses[index].CourseId,));
                                                return false;
                                              }
                                            },
                                            child: CustomStep(
                                              title: model.allTeacherCreatedCourses[index].CourseLessonDetails[index1]
                                                  .LessonTitle,
                                              subTitle:'${model.allTeacherCreatedCourses[index]
                                                  .CourseLessonDetails[index1].CourseVideos.length} فيديو',
                                              stepNum: index1 + 1,
                                              price:  Text(model.allTeacherCreatedCourses[index].CourseLessonDetails[index1].
                                                 LessonPrice.toString()),
                                              icon: const Icon(
                                                Icons.play_circle,
                                                color: AppColors.primaryColor,
                                              ),
                                              onTap: () {
                                                GlobalMethods.navigate(context, VideosPage(model: model,
                                                    courseLessons: model.allTeacherCreatedCourses[index]
                                                        .CourseLessonDetails[index1]));
                                              },
                                              IsSubscribed: true,
                                              IsLessonSubscribed: true,
                                            ),
                                          )),

                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                       children: [
                                         CustomElevatedButton(title: 'أضف درس',
                                          function: ()=> GlobalMethods.navigate(context,
                                              CreateCourseLessonPage(courseId:model.allTeacherCreatedCourses[index].CourseId ,))

                                  ),
                                         CustomElevatedButton(title: 'أضف اختبار',
                                          function: ()=> GlobalMethods.navigate(context,
                                              TeacherCreateExamPage(courseId: model.allTeacherCreatedCourses[index].CourseId,))

                                  ),
                                       ],
                                     ),

                                ],
                              ),
                            ),
                          )

                      ):
                           Image.asset('assets/images/no_data.png'),

                ),
                if(UserSession.hasPrivilege(1)) CustomElevatedButton(
                    title: 'اضافة كورس ',
                    function: () =>
                        GlobalMethods.navigate(context, CreateCoursePage())),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),

          ),
        );
      }
    );
  }
  changeEducationType(val){
    educationType=val;
    widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumType=null;
    setState(() {

    });

  }
  selectLevel(val){
    educationLevel=val;

    setState(() {
    });
  }
  change_educationPrograms(val){
    curriculumType=val;

    setState(() {

    });
  }
}



Widget subjectContainer(context, CustomModel sub) => Column(
  children: [
    Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFBBDDF8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Image.asset(
        'assets/icons/arabic_book.png',
        width: 40,
        height: 40,
      ),
    ),
    Text(
      sub.Name,
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    )
  ],
);

Widget courseContainer(context,TeacherCourseForAll teacherCourseForAll) {
  return Row(
    children: [
      Image.asset(
        'assets/images/notification.png',
        width: 40,
        height: 40,
      ),
      const SizedBox(
        width: 6,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(teacherCourseForAll.Title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
          Text(teacherCourseForAll.SubjectName,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      // const Spacer(),
      //  Text(teacherCourseForAll.Price.toString()),
    ],
  );
}
