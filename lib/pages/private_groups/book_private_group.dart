import 'dart:convert';

import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/model/subject/subject.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../model/mainmodel.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'component/drop_down.dart';
import 'component/multiSelect_drowpDown.dart';

class BookPrivateGroupPage extends StatefulWidget {
  BookPrivateGroupPage({ required this.model ,Key? key}) : super(key: key);
    MainModel model;
  @override
  State<BookPrivateGroupPage> createState() => _BookPrivateGroupPageState();
}

class _BookPrivateGroupPageState extends State<BookPrivateGroupPage> {

  List<CustomModel>? teachers=[];

  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;


  Subject ? subject;
  bool _teacherLoading=false;
  bool _bookLoading=false;
  int _selected_id=0;

  List<CustomModel> _teachersBySubject=[];

  List<SubscriptionPeriod> subscriptionPeriodList = [
    SubscriptionPeriod(1, 'سنة'),
    SubscriptionPeriod(2, 'ترم'),
    SubscriptionPeriod(3, 'شهر'),
    SubscriptionPeriod(4, 'حصة'),
  ];

  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;

    return ScopedModelDescendant<MainModel>(
        builder:(context,child,MainModel model){
        return ListView(
            shrinkWrap: true,
            children: [
              DropDownPrivateBooking(model.allSubjects ,
                  changeSubject, subject,'المادة'),
              const SizedBox(height: 5,),
              Text('اختر مدرس', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              _teacherLoading ?
              Center(
                  child: CircularProgressIndicator()):
                 MultiSelectDropDown(_teachersBySubject,
                     selectTeachers, 'اسم المدرس'),
                      const SizedBox(height: 5,),
              // Text('مدرسين مقترحين', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     ...suggestedTeachers.map((e) => InkWell(child: suggestedTeacherContainer(e), onTap: ()=> chooseTeacher(e)),)
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: const Text('فرد'),
                          value: TypeGroup.single,
                          groupValue: typeGroup,
                          onChanged: (value) {
                            typeGroup = value!;
                            setState(() {});
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('مجموعة'),
                          value: TypeGroup.group,
                          groupValue: typeGroup,
                          onChanged: (value) {
                            typeGroup = value!;
                            setState(() {});
                          })),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: RadioListTile(
                          title: const Text('مساءا'),
                          value: TypeTime.night,
                          groupValue: typeTime,
                          onChanged: (value) {
                            typeTime = value!;
                            setState(() {});
                          })),
                  Expanded(
                      child: RadioListTile(
                          title: const Text('صباحا'),
                          value: TypeTime.morning,
                          groupValue: typeTime,
                          onChanged: (value) {
                            typeTime = value!;
                            setState(() {});
                          })),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                children: [
                  const Icon(Icons.access_time),
                  const SizedBox(width: 10,),
                  Text('مدة الاشتراك', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
              const SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...subscriptionPeriodList.map((e) => InkWell(child:
                    subscriptionPeriodContainer(e),
                      onTap: ()=> changePeriod(e)),)
                ],
              ),
              const SizedBox(height: 20,),
              _bookLoading ?Center(child: CircularProgressIndicator()):
              buildElevatedButton('احجز موعد', (){
                _selected_id ==0?
                ShowMyDialog.showMsg('يرجي إختيار مدة الإشتراك لإتمام الحجز')
                :_book();
              }),
              const SizedBox(height: 15,),

            ],
          );
      }
    );
  }

  changeSubject(val){
    subject = val;

    setState(() {
      teachers=[];
      _getSubTeachers1(subject!.Id);
    });

  }

  selectTeachers(val){
    teachers = val;
  }

  changePeriod(SubscriptionPeriod subscriptionPeriod){
    for(var i = 0; i< subscriptionPeriodList.length; i++ ){
      if(subscriptionPeriodList[i].id == subscriptionPeriod.id){
        subscriptionPeriodList[i].isActive = true;
        setState(() {
          _selected_id= subscriptionPeriodList[i].id;
        });
      }
      else{
        subscriptionPeriodList[i].isActive = false;
      }
    }
    setState(() {});
  }

  chooseTeacher(SuggestedTeacher suggestedTeacher){
    // teacher = suggestedTeacher.name;
    setState(() {


    });
  }

  Widget subscriptionPeriodContainer(SubscriptionPeriod subscriptionPeriod) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
        color: subscriptionPeriod.isActive ? AppColors.primaryColor : Colors.white
    ),
    child: Center(child: Text(subscriptionPeriod.txt, style: TextStyle(fontSize: 12, color: subscriptionPeriod.isActive ? Colors.white : AppColors.primaryColor),)),
  );

  Widget suggestedTeacherContainer(SuggestedTeacher suggestedTeacher) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    margin: const EdgeInsets.only(right: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryColor),
    ),
    child: Center(child: Text(suggestedTeacher.name, style:
    TextStyle(fontSize: 12, color: AppColors.primaryColor),)),
  );

  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(40),
      ),
      child: Text(title),
    );
  }

  void _getSubTeachers1 (int subjectId) async{

  setState(() {
    _teacherLoading=true;
  });
    Map<String,dynamic> data={
      'subjectId':subjectId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetSubjectTeachers", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _teachersBySubject= body.map((e) => CustomModel.fromJson(e)).toList();
        setState(() {
          _teacherLoading=false;
        });
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _teacherLoading=false;
      });
    }
    catch(e){
      setState(() {
        _teacherLoading=false;
      });
      print(' teacher  ee '+e.toString());
    }
  }

  void _book()  async{
    setState(() {
      _bookLoading=true;
    });
    List <int> _t=teachers!.map((TeachersBySubject) => TeachersBySubject.Id).toList();

    Map data={
        "SubjectId": subject!.Id.toString(),
       // "Teachers":_t.map((i) => i.toString()).join(','),
        "GroupType": typeGroup==TypeGroup.single ? 1.toString() :2.toString(),
        "Timing":typeTime==TypeTime.morning ?1.toString():2.toString(),
        "SubscribtionPeriod": _selected_id.toString()
    };
    for(int i=0 ;i <_t.length ;i++){
      data.addAll({'Teachers['+i.toString()+']':_t[i].toString()});
    }

    //  print ('data77'+data.toString());
    try {
      var response = await CallApi().postData(data, "/api/Group/BookGroupAppointment", 1);
      var body = json.decode(response.body);
      print ('body '+body.toString());
      if (response != null && response.statusCode == 200) {

        ShowMyDialog.showMsg("تم الحجز بنجاح");

      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _bookLoading=false;
      });
    }
    catch(e){
      setState(() {
        _bookLoading=false;
      });
      print(' book  ee '+e.toString());
    }
  }


}

enum TypeGroup{
  group,
  single
}

enum TypeTime{
  night,
  morning
}

class SubscriptionPeriod{
  int id;
  String txt;
  bool isActive;

  SubscriptionPeriod(this.id, this.txt, {this.isActive = false});
}

class SuggestedTeacher{
  int id;
  String name;
  bool isActive;

  SuggestedTeacher(this.id, this.name, {this.isActive = false});
}

