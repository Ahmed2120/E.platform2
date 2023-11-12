import 'dart:convert';
import 'dart:io';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../model/customModel.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../../widgets/drop_downs/custom_dropdown.dart';
import '../login_page/login_page.dart';
import 'components/drop_down.dart';
import 'components/multi_select_Dwon.dart';
import 'components/otp_dialog.dart';
import 'components/register_field.dart';
import 'components/register_pages_lists.dart';
import 'package:file_picker/file_picker.dart';

class TeacherRegisterPage extends StatefulWidget {
  const TeacherRegisterPage({Key? key}) : super(key: key);

  @override
  State<TeacherRegisterPage> createState() => _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends State<TeacherRegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _idController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool isPassword=true;
  bool isConfirmPassword=true;
  bool hasProgram=false;

  int currentPage = 1;

  int gender = 1;

  bool _country_loading=false;

  List<CustomModel> _countries=[];
  List <String> countries=[];
  int  ? _country_index ;
  String ? country;


  List<CustomModel> _cities=[];
  List <String> cities=[];
  int  ? _city_index ;
  String ? city;

  List<CustomModel> _areas=[];
  List <String> areas=[];
  int  ? _area_index ;
  String ? area;

  List<CustomModel> _educatationType=[];
  List <String> educationTypeList=[];
  int  ? _e_type_index ;
  CustomModel? educationType;

  List<CustomModel> _education_level=[];
  List <String>educationLevelList=[];
  int  ? _e_level_index ;
  List<String>   selectedEducationLevel = [];

  List<CustomModel> _academic_year=[];
  List <String>academicYearList=[];
  int  ? _e_academic_index ;
  String  ? academicYear;

  List<CustomModel> _subjects=[];
  List <String>subjects=[];
  int  ? _e_subject_index ;
  List<String>   selectedSubjects = [];

  List<CustomModel> _education_programs=[];
  List <String> educationPrograms=[];
  int  ? _e_program_index ;
  List<String>   selectEdducationPrograms = [];

  List<CustomModel?> selectedEducationTypeList = [null];
  List<List<CustomModel>?> curriculumTypeList = [null];
  List<CustomModel?> selectedCurriculumTypeList = [null];
  List<List<CustomModel>?> gradesList = [null];
  List<CustomModel?> selectedGradesList = [null];
  List<List<CustomModel>?> subjectList = [null];
  List<CustomModel?> selectedSubjectList = [null];

  File? cv;
  File? certificate;
  File? promo;

  bool _reg_loading=false;
  bool _verify_loading=false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCountry();
    _get_educationType();
    // _get_grades();
  }

  @override
  Widget build(BuildContext context) {
    final  height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.dataBackgroundColor,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Row(
                children: const [
                  Icon(Icons.person, color: AppColors.primaryColor,),
                  Text('انشاء حساب كمدرس'),
                ],
              ),
              Image.asset('assets/images/register.png', height: height*0.20,),
              if(currentPage == 1 )...firstPage( _nameController,
                  _phoneController, _idController, _emailController, _passwordController,
                  _confirmPasswordController, gender, changeGender: changeGender, isPassword: isPassword, isConfirmPassword: isConfirmPassword, togglePass: togglePass, toggleConfirmPass: toggleConfirmPass),
              if(currentPage == 2 )...secondPage(countries: countries, changeCountry: changeCountries, country: country, cities: cities, changeCity: changeCities, city: city, areas: areas, changeArea: changeAreas, area: area),
              // if(currentPage == 3 )...teacherThirdPage(
              //     educationTypeList: educationTypeList, changeEducationType: changeEducationType,
              //     educationType: educationType, educationLevelList: educationLevelList, changeEducationLevel: changeEducationLevel,
              //     selectedEducationLevels: selectedEducationLevel, subjects: subjects, changeSubject: changeSubject, selectedSubjects: selectedSubjects,
              //     educationPrograms: educationPrograms, changeEducationPrograms: changeEducationPrograms, selectEdducationPrograms: selectEdducationPrograms, hasProgram: hasProgram),
              if(currentPage == 3 ) _thirdPage(),
              if(currentPage == 4 )...teacherFourthPage(getCV: getCv,
                getCertificate: getCertificate, getPromo: getPromo, cv: cv, certificate: certificate, promo: promo),
              const SizedBox(height: 20,),
              currentPage == 4
                  ?
              _reg_loading ==true ?Center(child: CircularProgressIndicator()):
              CustomElevatedButton(title: 'انشاء حساب', function: () async{
                ////// Even activate OPT
                // showDialog(context: context, builder: (context)=> OtpDialog(), barrierDismissible: false);
                if(!_formKey.currentState!.validate()) return;
                try{
                  final success = await _reg();
                  if(success){
                    if(!mounted) return;
                    // showDialog(context: context, builder: (context)=>
                    //     OtpDialog(phoneNumber: _phoneController.text,
                    //       navigateTo: LoginPage(),), barrierDismissible: false);
                    _sendOtp();

                  }
                }catch(e){
                  ShowMyDialog.showMsg(e);
                }
              })
                  : Align(alignment: Alignment.centerLeft,child: buildNextButton(changePage),),
              const SizedBox(height: 12,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _thirdPage(){
    return Column(
      children: [

        ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: curriculumTypeList.length,
            separatorBuilder: (context, index)=> const SizedBox(height: 10,),
            itemBuilder: (context, index) {
              return Row(
                children: [

                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  CustomDropDown(_educatationType, (val){
                                    changeEducationType(val, index);
                                  }, selectedEducationTypeList[index], 'نوع التعليم'),

                                ],
                              ),
                            ),

                            const SizedBox(width: 5,),
                            if(curriculumTypeList[index] != null && curriculumTypeList[index]!.isNotEmpty)
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomDropDown(curriculumTypeList[index]!,
                                            (val){
                                          change_educationPrograms(val, index);
                                        }, selectedCurriculumTypeList[index], 'نوع المنهج'),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 5,),
                        Row(
                          children: [
                            if(gradesList[index] != null && gradesList[index]!.isNotEmpty)
                            Expanded(
                              child: Column(
                                children: [
                                  CustomDropDown(gradesList[index]!, (val){
                                    changeEducationLevel(val, index);
                                  }, selectedGradesList[index], 'السنة الدراسية'),

                                ],
                              ),
                            ),

                            const SizedBox(width: 5,),
                            if(subjectList[index] != null && subjectList[index]!.isNotEmpty)
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomDropDown(subjectList[index]!,
                                            (val){
                                          changeSubject(val, index);
                                        }, selectedSubjectList[index], 'المادة'),
                                  ],
                                ),
                              ),
                          ],
                        )
                      ],
                    ),
                  ),


                  const SizedBox(width: 10,),
                  if(index == curriculumTypeList.length - 1)
                    InkWell(
                        onTap: ()
                        {
                          curriculumTypeList.add(null);
                          selectedEducationTypeList.add(null);
                          selectedCurriculumTypeList.add(null);
                          gradesList.add(null);
                          selectedGradesList.add(null);
                          subjectList.add(null);
                          selectedSubjectList.add(null);
                          setState(() {});
                        },
                        child: const Icon(Icons.add_circle_sharp,
                          color: AppColors.primaryColor, size: 40,))
                ],
              );
            }
        ),
      ],
    );
  }

  changePage(){
    if(currentPage == 4) return;
    if(currentPage == 1) {
      _formKey.currentState!.save();
      if (!_formKey.currentState!.validate()) return;
    }else if(currentPage == 2) {
      if(country == null || city == null || area == null){
        ShowMyDialog.showMsg('الرجاء ملئ جميع الحقول');
        return;
      }
    }
    // else if(currentPage == 3) {
    //   if(educationType == null || selectedEducationLevel.isEmpty || subjects.isEmpty){
    //     ShowMyDialog.showMsg('الرجاء ملئ جميع الحقول');
    //     return;
    //   }
    // }
    currentPage ++;
    setState(() {});

  }

  changeCountries(value){
    country=value;
    setState(() {
      _country_index = _countries.indexWhere((item) => item.Name== value);
      _getCities();
    });
    print ("country index  "+_country_index.toString());
  }

  changeCities(value){
    city=value;
    setState(() {
      _city_index = _cities.indexWhere((item) => item.Name== value);
      _getAreaes();
    });
    print ("city index  "+_city_index.toString());
  }

  changeAreas(value){
    area=value;
    setState(() {
      _area_index = _areas.indexWhere((item) => item.Name== value);
    });

  }

  changeGender(value){
    gender = value;
    setState(() {});
  }

  changeEducationType(val, int index) async{
    educationType=val;
    selectedEducationTypeList[index] = val;
    await _getEducationPrograms(educationType!.Id);
    curriculumTypeList[index] = _education_programs;

    if(curriculumTypeList[index]!.isEmpty){
      await _get_grades(educationType!.Id, null);
      gradesList[index] = _education_level;
    }
    // curriculumType=null;
    setState(() {

    });
  }

  changeEducationLevel(val, int index) async{

    selectedGradesList[index] = val;
    await _get_subjects(selectedEducationTypeList[index]!.Id, selectedGradesList[index]!.Id, selectedCurriculumTypeList[index]?.Id);
    subjectList[index] = _subjects;
    setState(() {
    });

  }

  changeAcademicYear(value){
    academicYear=value;
    _e_academic_index = _academic_year.indexWhere((item) => item.Name== value);
    setState(() {
    });

  }
  changeSubject(val, int index){
    // curriculumType=val;
    selectedSubjectList[index] = val;
    setState(() {

    });
  }

  // changeEducationPrograms(value){
  //   selectEdducationPrograms=value;
  //   // _e_program_index = _education_programs.indexWhere((item) => item.Name== value);
  //   setState(() {
  //   });
  //
  // }
  change_educationPrograms(val, int index) async{
    // curriculumType=val;
    selectedCurriculumTypeList[index] = val;

    await _get_grades(selectedEducationTypeList[index]!.Id, selectedCurriculumTypeList[index]!.Id);
    gradesList[index] = _education_level;
    setState(() {

    });
  }

  togglePass(){
    isPassword = !isPassword;
    setState(() {
    });

  }

  toggleConfirmPass(){
    isConfirmPassword = !isConfirmPassword;
    setState(() {
    });

  }

  getCv() async{
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if(picked != null){
      cv = File(picked.files.single.path!);
      setState(() {

      });

    }
  }
  getCertificate() async{
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if(picked != null){
      certificate = File(picked.files.single.path!);
      setState(() {

      });

    }
  }
  getPromo() async{
    final picked = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if(picked != null){
      promo = File(picked.path);
      setState(() {

      });
    }
  }

  Widget buildNextButton(Function function,) {
    return InkWell(
      onTap: ()=> function(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.primaryColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child: Icon(Icons.arrow_left_sharp, color: AppColors.primaryColor, size: 10,)),
            SizedBox(width: 3,),
            Text('التالي', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),

          ],),
      ),
    );}

  void _getCountry() async{

    setState(() {
      _country_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/Country/GetCountries",0);

      List body = json.decode(response.body);
      print ("Country " +body.toString());

      if (response != null && response.statusCode == 200) {
        _countries=body.map((e) => CustomModel.fromJson(e)).toList();
        countries= _countries.map((CustomModel) => CustomModel.Name).toList();
      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  void _getCities() async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "countryId" :_countries[_country_index!].Id.toString()
    };
    print ("country_id "+_countries[_country_index!].Id.toString());
    try {
      var response = await CallApi().getWithBody(data,"/api/City/GetCitiesByCountryId",0);

      List body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        _cities=body.map((e) => CustomModel.fromJson(e)).toList();
        //   _customCity=new City(Id: _countries[0].Id, Name: _countries[0].Name);

        cities= _cities.map((CustomModel) => CustomModel.Name).toList();
        print("City  " +_cities[0].Name);
      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  void _getAreaes() async{
    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "cityId" :_cities[_city_index!].Id.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/state/get-states",0);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

        _areas=body.map((e) => CustomModel.fromJson(e)).toList();

        areas= _areas.map((CustomModel) => CustomModel.Name).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  void _get_educationType() async{

    setState(() {
      _country_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/EducationType/GetEducationTypes",0);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _educatationType=body.map((e) => CustomModel.fromJson(e)).toList();
        educationTypeList= _educatationType.map((CustomModel) => CustomModel.Name).toList();
      }
    }
    catch(e){

      ShowMyDialog.showSnack(context,'ee '+e.toString());

    }
    setState(() {
      _country_loading=false;
    });
  }

  Future _get_grades(int educationTypeId, int? programTypeId) async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :educationTypeId.toString(),
      "programTypeId" : programTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Grade/GetGradesByEducationProgramType",0);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _education_level=body.map((e) => CustomModel.fromJson(e)).toList();
        educationLevelList= _education_level.map((CustomModel) => CustomModel.Name).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  Future _get_subjects(int educationTypeId, int gradeId, int? programTypeId) async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" : educationTypeId.toString(),
      "gradeId" : gradeId.toString(),
      "programTypeId" : programTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Subject/GetSubjects",0);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _subjects=body.map((e) => CustomModel.fromJson(e)).toList();
        subjects= _subjects.map((CustomModel) => CustomModel.Name).toList();

      }
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  Future _getEducationPrograms(int educationTypeId) async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :educationTypeId.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/EducationProgram/GetEducationPrograms",0);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _education_programs =body.map((e) => CustomModel.fromJson(e)).toList();
        educationPrograms= _education_programs.map((CustomModel) => CustomModel.Name).toList();
        if(educationPrograms.isEmpty) {
          hasProgram = false;
        }else{
          hasProgram = true;
        }

        print ('eennnnn $hasProgram');
        print ('eennnnn $educationPrograms');
        setState(() {});

      }
    }
    catch(e){
      print ('ee '+e.toString());
      ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _country_loading=false;
    });
  }

  Future<bool> _reg()  async {
    setState(() {
      _reg_loading=true;
    });

    //  List<int>e=[];
    //  e.add(_educatationType[_e_type_index!].Id);
    //
    // List<int>g=[];
    // for(int i = 0; i < selectedEducationLevel.length; i++) {
    //   final index = _education_level.indexWhere((item) => item.Name== selectedEducationLevel[i]);
    //   g.add(_education_level[index].Id);
    // }

    // List<int>s=[];
    // for(int i = 0; i < selectedSubjects.length; i++) {
    //   final index = _subjects.indexWhere((item) => item.Name== selectedSubjects[i]);
    //   s.add(_subjects[index].Id);
    // }

    // List<int>p=[];
    // for(int i = 0; i < selectEdducationPrograms.length; i++) {
    //   final index = _education_programs.indexWhere((item) => item.Name== selectEdducationPrograms[i]);
    //   p.add(_education_programs[index].Id);
    // }

    Map<String, String> types = {};
    for(int i = 0; i < selectedEducationTypeList.length; i++){
      if(selectedEducationTypeList[i] != null){
        types['EducationTypeIds[$i]'] = selectedEducationTypeList[i]!.Id.toString();
      }
      if(selectedCurriculumTypeList[i] != null){
        types['ProgramTypeIds[$i]'] = selectedCurriculumTypeList[i]!.Id.toString();
      }
      if(selectedGradesList[i] != null){
        types['GradeIDs[$i]'] = selectedGradesList[i]!.Id.toString();
      }
      if(selectedSubjectList[i] != null){
        types['SubjectIDs[$i]'] = selectedSubjectList[i]!.Id.toString();
      }
    }

    Map<String, String> data={
      'Name':_nameController.text.toString(),
      'PhoneNumber':_phoneController.text.toString(),
      'NationalId':_idController.text.toString(),
      'Email':_emailController.text.toString(),
      'Password': _passwordController.text.toString(),
      'Gender':gender.toString(),
      'StateId':_areas[_area_index!].Id.toString(),
      ...types,
      'UserType': 2.toString(),
      'StudyingDegreeCertificate': 'teacher',
      'StudyingDegree': 'teacher',
      'CV': 'teacher',
      'DeviceToken': 'teacher'
    };

    // for(int i = 0; i< e.length; i++){
    //   data.addAll({"EducationTypeIDs[$i]": e[i].toString()});
    // }
    // for(int i = 0; i< g.length; i++){
    //   data.addAll({"GradeIDs[$i]": g[i].toString()});
    // }
    // for(int i = 0; i< s.length; i++){
    //   data.addAll({"SubjectIDs[$i]": s[i].toString()});
    // }
    // for(int i = 0; i< p.length; i++){
    //   data.addAll({"ProgramTypeIDs[$i]": p[i].toString()});
    // }

    List<File?> files = [
      cv, certificate, promo
    ];

    print ("data222 "+data.toString());
    try {
    //  var response = await CallApi().postData(json.encode(data),"/api/Account/Register",0);
      var request = http.MultipartRequest('POST', Uri.parse(UserSession.getURL()+'/api/Account/Register'));

      request.fields.addAll(data);
      if(certificate != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'Certificate', certificate!.path));
      }
      if(cv != null) {
        request.files.add(await http.MultipartFile.fromPath('CV', cv!.path));
      }
      if(promo != null) {
        request.files
            .add(await http.MultipartFile.fromPath('Intro', promo!.path));
      }

      http.StreamedResponse response = await request.send();

      // final response = await http.post(
      //     Uri.parse(UserSession.getURL()+'/api/Account/Register'),
      //     body:json.encode(data),
      //     headers: { 'Content-Type': 'application/json',}
      // );
      // var body = json.decode(await response.stream.bytesToString());
      // var res = await http.Response.fromStream(response);
      // final body = jsonDecode(res.body) as Map<String, dynamic>;
      // print(body.toString());
      if (response != null && response.statusCode == 200) {

        // if(body['Success'] ==true) {
          // GlobalMethods.navigate(context, LoginPage());
          setState(() {
            _reg_loading=false;
          });
          return true;
        // }
        // throw body['Message'];
      }
      else{
        // ShowMyDialog.showMsg(body['Message']);
         throw response.reasonPhrase.toString();
      }
      setState(() {
        _reg_loading=false;
      });
    }
    catch(e){
      setState(() {
        _reg_loading=false;
      });
      //  ShowMyDialog.showMsg(context,'ee '+e.toString());
      print('ee '+e.toString());
      rethrow;

    }
  }

  void _sendOtp()  async {
    setState(() {
      _verify_loading=true;
    });

    Map  data={
      'PhoneNumber':_phoneController.text,
    };

    print ("body "+data.toString());
    try {
      var response = await CallApi().postData(data,"/api/Account/RequestVerificationCode",0);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        if(body['Success'] ==false) {
          ShowMyDialog.showMsg(body['Message']);
        }else{
          if(!mounted) return;
          // final navigator = Navigator.of(context);
          // navigator.pop();
          showDialog(context: context, builder: (context)=> OtpDialog(phoneNumber: _phoneController.text, navigateTo: LoginPage(),), barrierDismissible: false);
        }
      }
      else{
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _verify_loading=false;
      });
    }
    catch(e){
      setState(() {
        _verify_loading=false;
      });
      //  ShowMyDialog.showMsg(context,'ee '+e.toString());
      print('ee '+e.toString());

    }
  }

}
