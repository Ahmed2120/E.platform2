import 'dart:convert';

import 'package:eplatform/api/api.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/mainmodel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/groups/teacher_groups_videoPage.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../core/utility/app_colors.dart';
import '../../../session/userSession.dart';
import '../../../widgets/description_container.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/dialogs/delete_dialog.dart';
import '../create_group/create_groupClass_page.dart';
import 'edit_class_page.dart';
import 'edit_group_page.dart';
import 'homework/homework_details_page.dart';

class TeacherGroupsContentPage extends StatefulWidget {
  TeacherGroupsContentPage({required this.model,
  required this.group_title,required this.groupId ,Key? key}) : super(key: key);
  String group_title;
  int groupId;
  MainModel model;

  @override
  State<TeacherGroupsContentPage> createState() => _TeacherGroupsContentPageState();
}

class _TeacherGroupsContentPageState extends State<TeacherGroupsContentPage> {
  final _searchController = TextEditingController();

  CustomModel? subject;
  CustomModel? educationType;
  CustomModel? educationLevel;
  CustomModel? curriculumType;
  CustomModel? period;
  String  _daysString='';

  List gro = [
    'الحصة الاولى ',
    'الحصة الثانية ',
    'الحصة الثالثة ',
    'الحصة الرابعة ',
    'الحصة الخامسة ',
    'الحصة السادسة ',
    'الحصة السابعة ',
    'الحصة الثامنة ',
    'الحصة التاسعة ',
    'الحصة العاشرة ',
    'الحصة الحادية عشر ',
    'الحصة الثانية عشر ',
    'الحصة الثالثة عشر ',
    'الحصة الرابعة عشر ',
    'الحصة الخامسة عشر ',
    'الحصة السادسة عشر ',
    'الحصة السابعة عشر ',
    'الحصة الثامنة عشر ',
    'الحصة التاسعة عشر ',
  ];

  List<CustomModel> subscriptionPeriodList = [
    CustomModel(Id: 1,Name: 'حصة', NameEN: ''),
    CustomModel(Id: 2,Name: 'شهر', NameEN: ''),
    CustomModel(Id: 3,Name: 'ترم', NameEN: ''),
    CustomModel(Id: 4,Name: 'سنة', NameEN: ''),
  ];

  List <CustomModel>_days=[
    CustomModel(Id: 1, Name: 'السبت', NameEN: 'Saturday'),
    CustomModel(Id: 2, Name: 'الاحد', NameEN: 'Sunday'),
    CustomModel(Id: 3, Name: 'الاثنين', NameEN: 'Monday'),
    CustomModel(Id: 4, Name: 'الثلاثاء', NameEN: 'Tuesday'),
    CustomModel(Id: 5, Name: 'الاربعاء', NameEN: 'Wednesday'),
    CustomModel(Id: 6, Name: 'الخميس', NameEN: 'Thursday'),
    CustomModel(Id: 7, Name: 'الجمعة', NameEN: 'Friday'),];

  List homeworks = [
    {
      'title': 'الدرس الاول',
      'date': '1/6/2023',
      'from': '9:00',
      'to': '10:00',
    },
    {
      'title': 'الدرس الثاني',
      'date': '3/6/2023',
      'from': '9:00',
      'to': '10:00',
    },
    {
      'title': 'الدرس الثالث',
      'date': '6/6/2023',
      'from': '9:00',
      'to': '10:00',
    },
  ];

  bool _dataLoading=false;

  ContentType type = ContentType.classes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ggggg '+widget.groupId.toString());
    _getgroupData();
  }

  @override
  Widget build(BuildContext context) {
    type==ContentType.classes ? widget.model.fetchTeacherGroupSessions(widget.groupId):
        widget.model.fetchTeacherGroupStudents(widget.groupId);

    final deviceSize = MediaQuery.of(context).size;

    return  ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
          return Scaffold(
                body: CustomStack(
                  pageTitle: widget.group_title,
                  button: IconButton(
                    onPressed: ()
                    {
                      if(!UserSession.hasPrivilege(5)) {
                        ShowMyDialog.showMsg(
                            'You do not have the authority');
                        return ;
                      }
              GlobalMethods.navigate(
                  context,
                  EditGroupPage(
                    model: model,
                    groupId: widget.groupId,
                  ));
            },
                    icon: const Icon(Icons.edit),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                       Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        runAlignment: WrapAlignment.center,
                        alignment: WrapAlignment.center,
                        children: [
                          DescriptionContainer(title:subject==null?'': subject!.Name,
                              img: 'assets/icons/book-description.png'),
                          // const DescriptionContainer(title: 'مكتملة',
                          //     img: 'assets/icons/level-description.png'),
                          DescriptionContainer(title: period==null?'': period!.Name,
                              img: 'assets/icons/level-description.png'),
                          DescriptionContainer(title: _daysString,
                              img: 'assets/icons/level-description.png'),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(onTap: () =>
                              setState(() {
                                type = ContentType.classes;
                              }),child: Text('الحصص', style: TextStyle(fontSize: 17,
                              color: typeColor(ContentType.classes)),)),
                          GestureDetector(onTap: () =>
                              setState(() {
                                type = ContentType.students;
                              }),child: Text('الطلاب',
                            style: TextStyle(fontSize: 17, color: typeColor(ContentType.students)),)),
                          GestureDetector(onTap: () =>
                              setState(() {
                                type = ContentType.homework;
                              }),child: Text('الواجب', style: TextStyle(fontSize: 17, color: typeColor(ContentType.homework)),)),
                        ],
                      ),
                      const SizedBox(height: 10,),

                      if(type == ContentType.classes)
                        Expanded(
                          child:model.teacherGroupSessionsLoading?
                          const Center(child: CircularProgressIndicator()):
                           model.allTeacherGroupSessions.isNotEmpty?
                           ListView.builder(
                                shrinkWrap: true,
                                itemCount: model.allTeacherGroupSessions.length,
                                itemBuilder: (context, index)=>
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
                                                  title: 'هل تريد حذف حصة _ ${model.allTeacherGroupSessions[index].Title}؟',
                                                  onConfirm: () {},
                                                  loading: false)).then((value) {
                                            if(value !=null && value) {
                                              // TODO : REMOVE ITEM
                                              return true;
                                            }});}
                                        else {
                                          // GlobalMethods.navigate(context, EditGroupClassPage(groupVideoId: model.allTeacherGroupSessions[index].Id,));
                                          return false;
                                        }
                                      },
                                    child: InkWell(onTap: (){},
                                      //  GlobalMethods.navigate(context, TeacherGroupsVideosPage(model: model, courseLessons: model.allTeacherCourses[index].courseLessons[index])),
                                        child: classContainer(context,
                                            title:index > gro.length-1?'${index+1}حصة رقم ':gro[index],
                                            subtitle:model.allTeacherGroupSessions[index].Title,
                                        date:
                                        DateFormat("yyyy-MM-dd").format(DateTime.parse(model.allTeacherGroupSessions[index].ClassAt,)),

                                        time: model.allTeacherGroupSessions[index].FromTime+'  : '+model.allTeacherGroupSessions[index].ToTime
                                        ,)),
                                  ),

                            ):
                           Image.asset('assets/images/no_data.png'),
                      ),

                      if(type == ContentType.students) Expanded(
                        child:model.teacherGroupStudentsLoading?
                        const Center(child: CircularProgressIndicator()):
                        model.allTeacherGroupStudents.isNotEmpty?
                         ListView.builder(
                            shrinkWrap: true,
                            itemCount: model.allTeacherGroupStudents.length,
                            itemBuilder: (context, index)=>
                              InkWell(onTap: (){},
                                  child: studentContainer(context,
                                      name:model.allTeacherGroupStudents[index]['StudentName'] ,
                                  img: 'assets/images/student-profile.png'
                                  ,)),

                        ):
                        Image.asset('assets/images/no_data.png'),
                      ),

                      if(type == ContentType.homework) Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: homeworks.length,
                            itemBuilder: (context, index)=>
                              InkWell(onTap: ()=> GlobalMethods.navigate(context, HomeWorkDetailsPage()),
                                  child: homeworkContainer(context,
                                      title: 'واجب الحصة ${index + 1}',
                                      subtitle: homeworks[index]['title'],
                                  date: homeworks[index]['date'],
                                  time: ' ${homeworks[index]['from']} : ${homeworks[index]['to']}'
                                  ,)),

                        ),
                      ),

                      if(type == ContentType.homework) CustomElevatedButton(
                          title: 'انشاء الواجب',
                          function: (){}),

                      if(type == ContentType.classes) Row(
                        children: [
                          // CustomElevatedButton(
                          //     title: 'تعديل المجموعة',
                          //     function: ()=> GlobalMethods.navigate(context,
                          //         EditGroupPage(model: model,groupId: widget.groupId,))),
                          const SizedBox(width: 20,),
                          CustomElevatedButton(
                              title: 'اضافة حصة',
                              function: ()=> GlobalMethods.navigate(context, CreateGroupClassPage(groupId: widget.groupId,))),
                        ],
                      )

                    ],
                  ),
                ),
              );
      }
    );
  }

  Container classContainer(context, {
    required String title,
    required String subtitle,
    required String date,
    required String time,
  }) {
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
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium,),
              SizedBox(width: 100, child: Text(subtitle, style: Theme.of(context).textTheme.titleSmall,)),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(date,),
              SizedBox(width: 100, child: Text(time,)),
            ],
          ),
          const Icon(Icons.play_circle, color: AppColors.primaryColor, size: 50,)
        ],
      ),
    );
  }

  Container homeworkContainer(context, {
    required String title,
    required String subtitle,
    required String date,
    required String time,
  }) {
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
          Column(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium,),
              Text(subtitle, style: Theme.of(context).textTheme.titleSmall,),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Text(date,),
              Text(time,),
            ],
          ),
          const SizedBox(width: 8,),
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

  Container studentContainer(context, {
    required String name,
    required String img,
  }) {
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
          Image.asset(img, width: 70,),
          const SizedBox(width: 8,),
          Text(name, style: Theme.of(context).textTheme.titleMedium,),
          const Spacer(),
          const Icon(Icons.more_vert_sharp, size: 40,)
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

  Color typeColor(ContentType contentType){
    if(contentType == type) {
      return AppColors.primaryColor;
    } else {
      return AppColors.titleMediumColor;
    }
  }


  void _getgroupData() async{

    setState(() {
      _dataLoading=true;
    });
    Map <String,dynamic>data={
      'groupId':widget.groupId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Group/GetGroupById",1);

      var body = json.decode(response.body);
     print('bodyyyyy   '+body.toString());
      if (response != null && response.statusCode == 200) {
        subject = new CustomModel(
            Id: body['SubjectId'], Name: body['SubjectName'], NameEN: '');
        curriculumType = body['ProgramTypeId'] == null ? null : new CustomModel(Id: body['ProgramTypeId'],
            Name: body['ProgramTypeName'],
            NameEN: '');

        educationType =  body['EducationTypeId'] == null ? null :  new CustomModel(Id: body['EducationTypeId'],
            Name: body['EducationTypeName'], NameEN: '');


        period=new CustomModel(Id: body['Period'],
            Name:subscriptionPeriodList[ subscriptionPeriodList.indexWhere((element) =>
            element.Id==body['Period'])].Name,
            NameEN: '');

        setState(() {

        });


        List GroupAppointments = body['GroupAppointments'];

        for (int i = 0; i < GroupAppointments.length; i++) {
          _daysString= _days[ _days.indexWhere((element) =>
          element.Id==GroupAppointments[i]['Day'])].Name+' ';

         print (_days[ _days.indexWhere((element) =>
         element.Id==GroupAppointments[i]['Day'])].Name);

        }


        setState(() {});
      }
      }

    catch(e){
      print (' show ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
    }
    setState(() {
      _dataLoading=false;
    });
  }


}

enum ContentType{
  classes,
  students,
  homework

}