import 'dart:convert';

import 'package:eplatform/model/customModel.dart';
import 'package:flutter/material.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/privateGroup/PrivateGroup.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'components/drop_down.dart';
import 'lessons_page.dart';

class BookAppointmentPage extends StatefulWidget {
  BookAppointmentPage({ required this.teacherId,required this.teacherName ,Key? key}) : super(key: key);
    int teacherId;
    String teacherName;

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
   CustomModel ? subject;
   bool _loading=false;
   bool _bookLoading=false;
   List<CustomModel> _sub=[];
   int _selected_id=0;

  TypeGroup typeGroup = TypeGroup.group;
  TypeTime typeTime = TypeTime.morning;

  List<SubscriptionPeriod> subscriptionPeriodList = [
    SubscriptionPeriod(1, 'سنة'),
    SubscriptionPeriod(2, 'ترم'),
    SubscriptionPeriod(3, 'شهر'),
    SubscriptionPeriod(4, 'حصة'),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSubOfTeacher();
  }

  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),
                    topRight: Radius.circular(20), )
              ),
              child:  Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Text(widget.teacherName,
                      style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,),
                    const SizedBox(height: 12,),
                    _loading ?CircularProgressIndicator():
                    DropDownBooking(_sub, changeSubject, subject, 'المادة'),
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
                      children: const [
                        Icon(Icons.access_time),
                        SizedBox(width: 10,),
                        Text('مدة الاشتراك', style: TextStyle(color: Colors.black, fontSize: 15),),
                      ],
                    ),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 5),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     boxShadow: const [
                    //       BoxShadow(
                    //           color: Colors.black12,
                    //           blurRadius: 6,
                    //           spreadRadius: 3
                    //       )
                    //     ],
                    //   ),
                    //   // child: TextFormField(
                    //   //   controller: _timeController,
                    //   //   decoration: const InputDecoration(
                    //   //     border: InputBorder.none,
                    //   //     suffixIcon: Icon(Icons.access_time, size: 25,),
                    //   //     hintText: 'مدة الاشتراك',
                    //   //   ),
                    //   // ),
                    // ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ...subscriptionPeriodList.map((e) =>
                            InkWell(child: subscriptionPeriodContainer(e),
                                onTap: ()=> changePeriod(e)),)
                      ],
                    ),
                    const Spacer(),
                    _bookLoading ?
                    Center(child: Center(child: CircularProgressIndicator())):
                    buildElevatedButton('احجز موعد', (){
                      _selected_id ==0?
                       ShowMyDialog.showMsg('يرجي إختيار مدة الإشتراك لإتمام الحجز')
                          :_book();
                    }),
                    const SizedBox(height: 15,),

                  ],
                ),),
            ),
                 Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32.0),
                const Text('احجز موعد', style: TextStyle(fontSize: 20, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),

                IconButton(
                  onPressed: ()=> Navigator.pop(context),
                  icon: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: const Icon(Icons.arrow_forward_ios_sharp, color: AppColors.primaryColor, size: 15,),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    );
  }

  changeSubject(val){
    subject = val;
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

  void _getSubOfTeacher()  async{
    setState(() {
      _loading=true;
    });
    Map<String,dynamic> data={
      'teacherId':widget.teacherId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data, "/api/Teacher/GetTeacherSubjects", 1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _sub= body.map((e) => CustomModel.fromJson(e)).toList();
        setState(() {
          _loading=false;
        });
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      setState(() {
        _loading=false;
      });
    }
    catch(e){
      setState(() {
        _loading=false;
      });
      print(' teacher  ee '+e.toString());
    }
  }

  void _book()  async{
    setState(() {
      _bookLoading=true;
    });

    Map data={
      "SubjectId": subject!.Id.toString(),
      "Teachers":[widget.teacherId].map((i) => i.toString()).join(','),
      "GroupType": typeGroup==TypeGroup.single ? 1.toString() :2.toString(),
      "Timing":typeTime==TypeTime.morning ?1.toString():2.toString(),
      "SubscribtionPeriod": _selected_id.toString()
    };

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