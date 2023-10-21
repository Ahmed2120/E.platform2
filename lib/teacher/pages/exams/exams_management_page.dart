import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/model/teacherModels/teacherExam.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/subject/subject.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/dialogs/delete_dialog.dart';
import '../teacher_create_exam/teacher_create_exam.dart';
import 'exam_details_page.dart';

class ExamsManagementPage extends StatefulWidget {
  ExamsManagementPage({required this.model,Key? key}) : super(key: key);
  MainModel model;

  @override
  State<ExamsManagementPage> createState() => _ExamsManagementPageState();
}

class _ExamsManagementPageState extends State<ExamsManagementPage> {
  CustomModel? teacher;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  int ?  _selectedSub;

   @override 
   void initState() {
     // TODO: implement initState
     super.initState();
     widget.model.fetchTeacherEducationType();
     widget.model.fetchTeacherEducationLevels();
  }

  @override
  Widget build(BuildContext context) {
     widget.model.fetchAllTeacherExams(_selectedSub,
         educationType==null ?null:  educationType!.Id,
         educationLevel==null ?null:  educationLevel!.Id,
         curriculumType==null ?null : curriculumType!.Id);
    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
          body: CustomStack(
            pageTitle: 'الاختبارات',
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child:
                      model.customEducationType?const Center(child: CircularProgressIndicator()):
                          CustomDropDown(model.allCustomEducationType, changeEducationType,
                              educationType, 'نوع التعليم'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: model.customEducationProgramsLoading?const Center(child: CircularProgressIndicator()):
                          CustomDropDown(model.allCustomEducationPrograms, change_educationPrograms, curriculumType, 'نوع المنهج'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child:
                      model.customLevel_loading ?const Center(child: CircularProgressIndicator()):
                      CustomDropDown(model.allCustomEducationLevels,selectLevel, educationLevel, 'السنة الدراسية'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 130,
                  child: model.subLoading? const Center(child: CircularProgressIndicator()):
                  ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.allTeacherSubjects.length,
                    itemBuilder: (context, index) => subjectContainer(context,model.allTeacherSubjects[index]),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child:
                      model.allTeacherExamLoading?Center(child: CircularProgressIndicator()):
                    model.allTeacherExams.isNotEmpty ?
                      ListView.builder(
                      shrinkWrap: true,
                      itemCount: model.allTeacherExams.length,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () => GlobalMethods.navigate(context, ExamDetailsPage(model: model, examId: model.allTeacherExams[index].ExamId, examTitle: model.allTeacherExams[index].Title,)),
                          child: Dismissible(
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
                                  if(!UserSession.hasPrivilege(9)) {
                                    ShowMyDialog.showMsg(
                                        'You do not have the authority');
                                    return false;
                                  }
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => DeleteDialog(
                                          title: 'هل تريد الحذف ؟',
                                          onConfirm: (){
                                            model.deleteTeacherCreatedExam(model.allTeacherExams[index].ExamId,index);

                                          },
                                          loading: false)).then((value) {
                                    if(value !=null && value) {
                                      // TODO : REMOVE ITEM
                                      return true;
                                    }});}
                                else{
                                  if(!UserSession.hasPrivilege(8)) {
                                    ShowMyDialog.showMsg(
                                        'You do not have the authority');
                                    return false;
                                  }
                                  // TODO: edit exam
                                  return false;
                                }

                              },

                              child: examContainer(context,model.allTeacherExams[index])))) :
                    Image.asset('assets/images/no_data.png')
                  ,
                ),
                const SizedBox(
                  height: 5,
                ),
                if(UserSession.hasPrivilege(7)) CustomElevatedButton(
                    title: 'انشاء اختبار',
                    function: () =>
                        GlobalMethods.navigate(context, TeacherCreateExamPage())),
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

  Widget subjectContainer(context,CustomModel sub) =>
      InkWell(
        onTap: () {
         _selectedSub=sub.Id;
         setState(() {

         });
        },
        child: Column(
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
            Text(sub.Name,
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            )
          ],
        ),
      );

  Widget examContainer(context,TeacherExam teacherExam) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 2), blurRadius: 5, color: Colors.grey)
          ]),
      child: Row(
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                teacherExam.Title,
                style: const TextStyle(fontSize: 14, color: Colors.black),
              ),
              Text(teacherExam.SubjectName,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  changeEducationType(val){
    educationType=val;
    widget.model.fetchTeacherEducationPrograms(educationType!);
    curriculumType=null;
    setState(() {

    });
  }
  change_educationPrograms(val){
    curriculumType=val;
    setState(() {

    });
  }

  selectLevel(val){
    educationLevel=val;
    setState(() {

    });
  }
}
