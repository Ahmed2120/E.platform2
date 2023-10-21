import 'dart:convert';
import 'dart:io';

import 'package:eplatform/api/teacherCall.dart';
import 'package:eplatform/model/teacher/curency.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/teacher/pages/create_course/components/multiselect_dropdown.dart';
import 'package:eplatform/widgets/custom_stack.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/api.dart';
import '../../../core/utility/app_colors.dart';
import '../../../model/customModel.dart';
import '../../../pages/components/custom_dotted_border.dart';
import '../../../session/userSession.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../widgets/drop_downs/custom_dropdown.dart';
import '../../../widgets/text_fields/change_value_field.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

import '../../../widgets/text_fields/custom_text_field.dart';

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.national,
    required this.grade,
    required this.educationType,
    required this.gradeId,
    required this.educationTypeId,
    required this.stateId, required this.school}) : super(key: key);

  final String? name, email, phone, national, grade, educationType, school;
  final int gradeId, educationTypeId, stateId;

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {


  CustomModel? educationType;
  CustomModel? educationLevel;


  List<CustomModel> _educationTypes=[];
  List<CustomModel> _educationLevels=[];

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _nationalController = TextEditingController();
  final _schoolController = TextEditingController();

  bool _Loading=false;
  bool _teacherLoading=false;
  bool _type_loading=false;
  bool _level_loading=false;
  bool _country_loading=false;
  bool _currency_loading=false;
  bool _educationProgramsLoading=false;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _get_currentData();
    _get_educationType();
    _get_educationLevels();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomStack(
        pageTitle: 'تعديل الملف الشخصي',
        child:
        ListView(
          shrinkWrap: true,
          children: [
            Text('الاسم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _nameController, hintText: 'الاسم', input: TextInputType.text,),

            const SizedBox(height: 5,),
            Text('الايميل', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _emailController, hintText: 'الايميل', input: TextInputType.text),

            const SizedBox(height: 5,),
            Text('رقم الهاتف', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _phoneController, hintText: 'رقم الهاتف', input: TextInputType.text,),

            const SizedBox(height: 5,),
            Text('الرقم القومي', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _nationalController, hintText: 'الرقم القومي', input: TextInputType.text,),

            const SizedBox(height: 5,),
            Text('المدرسة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomTextField(controller: _schoolController, hintText: 'المدرسة', input: TextInputType.text,),


            const SizedBox(height: 5,),
            Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomDropDown(_educationTypes, changeEducationType, educationType, 'نوع التعليم'),

            const SizedBox(height: 5,),
            _level_loading ?Center(child: CircularProgressIndicator()):
            Text('المرحلة الدراسية', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.right,),
            CustomDropDown(_educationLevels, selectLevel,educationLevel, 'المرحلة الدراسية'),

            const SizedBox(height: 20,),
            _Loading ?Center(child: CircularProgressIndicator())
                : Builder(
                builder: (context) {
                  return  CustomElevatedButton(title: 'حفظ', function:_updateProfile);
                }
            ),
            const SizedBox(height: 15,),

          ],
        ),
      ),
    );
  }


  selectLevel(val){
    educationLevel=val;
    setState(() {

    });
  }

  changeEducationType(val){
    educationType=val;
    setState(() {

    });
  }

  void _get_educationType() async{

    setState(() {
      _type_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/EducationType/GetEducationTypes",1);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _educationTypes=body.map((e) => CustomModel.fromJson(e)).toList();
      }
    }
    catch(e){

      ShowMyDialog.showSnack(context,'ee '+e.toString());

    }
    setState(() {
      _type_loading=false;
    });
  }

  void _get_educationLevels() async{

    setState(() {
      _level_loading=true;
    });


    try {
      var response = await CallApi().getData("/api/Grade/GetGrades",1);

      if (response != null && response.statusCode == 200) {
        List body =json.decode(response.body) ;
        _educationLevels=body.map((e) => CustomModel.fromJson(e)).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _level_loading=false;
    });
  }

  void _get_currentData(){
    educationLevel = CustomModel(Id: widget.gradeId, Name: widget.grade!, NameEN: '');
    educationType = CustomModel(Id: widget.educationTypeId, Name: widget.educationType!, NameEN: '');

    _nameController.text = widget.name!;
    _emailController.text = widget.email!;
    _phoneController.text = widget.phone!;
    _nationalController.text = widget.national!;
    _schoolController.text = widget.school ?? '';

    setState(() {});
  }

  void _updateProfile()  async{

    setState(() {
      _Loading=true;
    });

   Map data={
     "Name": _nameController.text,
     "Email": _emailController.text,
     "PhoneNumber": _phoneController.text,
     "NationalId": _nationalController.text,
     "StateId": widget.stateId.toString(),
     // "EducationTypeId": 1.toString(),
     // "GradeId": 1.toString(),
     "EducationTypeId": educationType!.Id.toString(),
     "GradeId": educationLevel!.Id.toString(),
     "SchoolName": _schoolController.text
    };

    print('data   '+data.toString());

    try {
      var response = await CallApi().postData(data, "/api/Student/UpdateStudentProfile", 1);
      var body = json.decode(response.body);
      print ('body '+body.toString());

      if (response != null && response.statusCode == 200) {
        if(body['Success']) {

          ShowMyDialog.showMsg("تم التعديل بنجاح");

          //  Navigator.of(context).pop();
        }
      }
      else {
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _Loading=false;
      });
    }
    catch(e){
      setState(() {
        _Loading=false;
      });
      print(' add Note  ee '+e.toString());
    }
  }




}
