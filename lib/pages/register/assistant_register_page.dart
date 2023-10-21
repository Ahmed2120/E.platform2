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
import '../components/custom_dotted_border.dart';
import '../login_page/login_page.dart';
import 'components/drop_down.dart';
import 'components/otp_dialog.dart';
import 'components/register_field.dart';
import 'components/register_pages_lists.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as pp;

class AssistantRegisterPage extends StatefulWidget {
  const AssistantRegisterPage({Key? key}) : super(key: key);

  @override
  State<AssistantRegisterPage> createState() => _AssistantRegisterPageState();
}

class _AssistantRegisterPageState extends State<AssistantRegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _idController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool isPassword=true;
  bool isConfirmPassword=true;

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
  String ? educationType;

  List<CustomModel> _education_level=[];
  List <String>educationLevelList=[];
  String ? educationLevel ;
  int  ? _e_level_index ;

  List<CustomModel> _academic_year=[];
  List <String>academicYearList=[];
  int  ? _e_academic_index ;
  String  ? academicYear;

  List<CustomModel> _subjects=[];
  List <String>subjects=[];
  int  ? _e_subject_index ;
  String ?  subject ;

  List<CustomModel> _education_programs=[];
  List<String> educationPrograms=[];
  String ? educationProgram;
  int  ? _e_program_index ;

  List<String> status = ['خريج', 'طالب'];
  String statusItem = 'خريج';

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
    _get_grades();
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
                  Text('انشاء حساب كمساعد'),
                ],
              ),
              Image.asset('assets/images/register.png', height: height*0.20,),
              if(currentPage == 1 )...firstPage( _nameController,
                  _phoneController, _idController, _emailController, _passwordController,
                  _confirmPasswordController, gender, changeGender: changeGender, isPassword: isPassword, isConfirmPassword: isConfirmPassword, togglePass: togglePass, toggleConfirmPass: toggleConfirmPass),
              if(currentPage == 2 )...secondPage(countries: countries, changeCountry: changeCountries, country: country, cities: cities, changeCity: changeCities, city: city, areas: areas, changeArea: changeAreas, area: area),
              if(currentPage == 3 ) last_page(),

                const SizedBox(height: 20,),
              currentPage == 3
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
                    _sendOtp(context);

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

  Widget last_page(){
    return Column(
      children: [
        DropDownRegister(status, changeStatus, statusItem, ''),
        const SizedBox(height: 12,),
        if(statusItem == 'خريج')Column(
          children: [
            Text('رفع السيرة الذاتية', style: TextStyle(color: Colors.black),),
            const SizedBox(height: 5,),
            InkWell(
              onTap: ()=> getCv(),
              child: CustomDottedBorder(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 32,),
                    Image.asset('assets/images/upload.png'),
                    Text(cv != null ? pp.basename(cv!.path) : 'تصفح'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text('رفع اخر شهادة', style: TextStyle(color: Colors.black),),
            const SizedBox(height: 5,),
            InkWell(
              onTap: ()=> getCertificate(),
              child: CustomDottedBorder(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 32,),
                    Image.asset('assets/images/upload.png'),
                    Text(certificate != null ? pp.basename(certificate!.path) : 'تصفح'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text('رفع برومو', style: TextStyle(color: Colors.black),),
            const SizedBox(height: 5,),
            InkWell(
              onTap: ()=> getPromo(),
              child: CustomDottedBorder(
                child: Column(
                  children: [
                    Image.asset('assets/images/promo.png'),
                    SizedBox(height: 6,),
                    Text(promo != null ? pp.basename(promo!.path) : 'تصفح'),
                  ],
                ),
              ),
            ),
          ],
        ),

        if(statusItem == 'طالب')Column(
          children: [
            DropDownRegister(educationTypeList, changeEducationType, educationType, 'نوع التعليم'),
            const SizedBox(height: 12,),
            DropDownRegister(educationPrograms, changeEducationPrograms, educationProgram, 'نوع المنهج'),
            const SizedBox(height: 12,),
            DropDownRegister(educationLevelList, changeEducationLevel, educationLevel, 'المرحلة الدراسية'),
            const SizedBox(height: 12,),
            DropDownRegister(subjects, changeSubject, subject, 'المادة'),
          ],
        )

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

  changeStatus(value){
    statusItem=value;
    setState(() {});
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

  changeEducationType(value){
    educationType=value;
    setState(() {
      _e_type_index = _educatationType.indexWhere((item) => item.Name== value);
      _getEducationPrograms();
    });

  }

  changeEducationLevel(value){
    educationLevel=value;
    _e_level_index = _education_level.indexWhere((item) => item.Name== value);
    _get_subjects();
    setState(() {
    });

  }

  changeAcademicYear(value){
    academicYear=value;
    _e_academic_index = _academic_year.indexWhere((item) => item.Name== value);
    setState(() {
    });

  }

  changeSubject(value){
    subject=value;
    _e_subject_index = _subjects.indexWhere((item) => item.Name== value);
    setState(() {
    });

  }

  changeEducationPrograms(value){
    educationProgram=value;
    _e_program_index = _education_programs.indexWhere((item) => item.Name== value);
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

  void _get_grades() async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      // "educationTypeId" :_educatationType[_e_type_index!].Id.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/Grade/GetGrades",0);
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

  void _get_subjects() async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :_educatationType[_e_type_index!].Id.toString(),
      "gradeId" :_education_level[_e_type_index!].Id.toString()
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

  void _getEducationPrograms() async{

    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :_educatationType[_e_type_index!].Id.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,
          "/api/EducationProgram/GetEducationPrograms",0);
      List body =json.decode(response.body) ;
      if (response != null && response.statusCode == 200) {
        _education_programs =body.map((e) => CustomModel.fromJson(e)).toList();
        educationPrograms= _education_programs.map((CustomModel) => CustomModel.Name).toList();

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

    List<int>e=[];
    e.add(_educatationType[_e_type_index!].Id);

    // List<int>g=[];
    // for(int i = 0; i < selectedEducationLevel.length; i++) {
    //   final index = _education_level.indexWhere((item) => item.Name== selectedEducationLevel[i]);
    //   g.add(_education_level[index].Id);
    // }
    //
    // List<int>s=[];
    // for(int i = 0; i < selectedSubjects.length; i++) {
    //   final index = _subjects.indexWhere((item) => item.Name== selectedSubjects[i]);
    //   s.add(_subjects[index].Id);
    // }
    //
    // List<int>p=[];
    // for(int i = 0; i < selectEdducationPrograms.length; i++) {
    //   final index = _education_programs.indexWhere((item) => item.Name== selectEdducationPrograms[i]);
    //   p.add(_education_programs[index].Id);
    // }

    Map<String, String> data={
      'Name':_nameController.text.toString(),
      'PhoneNumber':_phoneController.text.toString(),
      'NationalId':_idController.text.toString(),
      'Email':_emailController.text.toString(),
      'Password': _passwordController.text.toString(),
      'Gender':gender.toString(),
      'StateId':_areas[_area_index!].Id.toString(),
      'UserType': 6.toString(),
      "ProgramTypeIDs[0]": [_education_programs[_e_program_index!].Id].map((i) => i.toString()).join(','),
      "EducationTypeIDs[0]": [_educatationType[_e_type_index!].Id].map((i) => i.toString()).join(',') ,
          "GradeIDs[0]": [_education_level[_e_level_index!].Id].map((i) => i.toString()).join(','),
      "SubjectIDs[0]": [_subjects[_e_subject_index!].Id].map((i) => i.toString()).join(',') ,
"IsGraduated": statusItem == 'خريج' ? true.toString() : false.toString()
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

  void _sendOtp(context)  async {
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
