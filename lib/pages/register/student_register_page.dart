
import 'dart:convert';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/customModel.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'components/otp_dialog.dart';
import 'components/register_field.dart';
import 'components/register_pages_lists.dart';

class StudentRegisterPage extends StatefulWidget {
  const StudentRegisterPage({Key? key}) : super(key: key);

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _phoneController = TextEditingController();

  final _idController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  int currentPage = 1;

  int gender = 1;

  bool _country_loading=false;

  bool isPassword=true;
  bool isConfirmPassword=true;

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
  int  ? _e_level_index ;
  String  ? educationLevel;

  List<CustomModel> _education_programs=[];
  List <String> educationPrograms=[];
  int  ? _e_program_index ;
  String  ? educationProgram;

  bool _reg_loading=false;
  bool _verify_loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCountry();
    _get_educationType();
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
           shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                Text('انشاء حساب كطالب'),
                Icon(Icons.person, color: AppColors.primaryColor,)
              ],
            ),
           Image.asset('assets/images/register.png', height: height*0.20,),
            if(currentPage == 1 )...firstPage( _nameController,
                _phoneController, _idController, _emailController, _passwordController,
                _confirmPasswordController, gender, changeGender: changeGender, isPassword: isPassword, isConfirmPassword: isConfirmPassword, togglePass: togglePass, toggleConfirmPass: toggleConfirmPass),
            if(currentPage == 2 )...secondPage(countries: countries,
                changeCountry: changeCountries, country: country,
                cities: cities, changeCity: changeCities,
                city: city, areas: areas, changeArea: changeAreas, area: area),
            if(currentPage == 3 )...studentThirdPage(educationTypeList: educationTypeList,
                changeEducationType: changeEducationType, educationType: educationType,
                educationLevelList: educationLevelList,
                changeEducationLevel: changeEducationLevel, educationLevel: educationLevel,
            educationPrograms: educationPrograms, changeEducationPrograms: changeEducationPrograms, educationProgram: educationProgram),
            const SizedBox(height: 20,),
            currentPage == 3

                ?
            _reg_loading ==true ?
            Center(child: CircularProgressIndicator()):
            buildElevatedButton('انشاء حساب', () async{

              if(educationType == null || educationLevel == null || educationProgram == null){
                ShowMyDialog.showMsg('الرجاء ملئ جميع الحقول');
                return;
              }
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
            }, AppColors.primaryColor)
                : Align(alignment: Alignment.centerLeft,child: buildNextButton(changePage),),
            const SizedBox(height: 12,),
          ],
          ),
        ),
      ),
    );
  }

  changePage(){
    if(currentPage == 3) return;

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
      _get_gradesByEducationTypeId();
    });

  }

  changeEducationLevel(value){
    educationLevel=value;
    _e_level_index = _education_level.indexWhere((item) => item.Name== value);
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



  Widget buildNextButton(Function function,) {
    return InkWell(
      onTap: ()=> function(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.primaryColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text('التالي', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          SizedBox(width: 3,),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
              ),
              child: Icon(Icons.arrow_forward_ios_sharp, color: AppColors.primaryColor, size: 12,)),
        ],),
      ),
    );}

  ElevatedButton buildElevatedButton(String title, Function function,
      Color color) {
    return ElevatedButton(
      onPressed: () => function(),
      child: Text(title),
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: color == Colors.white
              ? AppColors.secondaryColor
              : null,
          minimumSize: const Size.fromHeight(40), // NEW
      ),
    );
  }


  void _getCountry() async{

    setState(() {
      _country_loading=true;
    });

    try {
      var response = await CallApi().getData("/api/Country/GetCountries",0);

      List body = json.decode(response.body);
   //    print ("Country " +body.toString());

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
    try {
      var response = await CallApi().getWithBody(data,"/api/City/GetCitiesByCountryId",0);

      List body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        _cities=body.map((e) => CustomModel.fromJson(e)).toList();
        //   _customCity=new City(Id: _countries[0].Id, Name: _countries[0].Name);

        cities= _cities.map((CustomModel) => CustomModel.Name).toList();

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

  void _get_gradesByEducationTypeId() async{
print('------------------------');
    setState(() {
      _country_loading=true;
    });
    Map <String, dynamic>data={
      "educationTypeId" :_educatationType[_e_type_index!].Id.toString()
    };

    try {
      // var response = await CallApi().getWithBody(data,
      //     "/api/EducationTypeGrade/GetGradesByEducationTypeId",0);
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

    Map  data={
      'Name':_nameController.text.toString(),
      'PhoneNumber':_phoneController.text.toString(),
      'NationalId':_idController.text.toString(),
      'Email':_emailController.text.toString(),
      'Password': _passwordController.text.toString(),
      'Gender':gender.toString(),
      'StateId':_areas[_area_index!].Id.toString(),
      'EducationTypeIDs':[_educatationType[_e_type_index!].Id].map((i) => i.toString()).join(',') ,
      'GradeIDs':[_education_level[_e_level_index!].Id].map((i) => i.toString()).join(','),
      'SubjectIDs': [0].map((i) => i.toString()).join(','),
      'ProgramTypeIDs': [_education_programs[_e_program_index!].Id].map((i) => i.toString()).join(','),
      'UserType': 1.toString(),
      'StudyingDegreeCertificate': 'student',
      'StudyingDegree': 'student',
      'CV': 'student',
      'DeviceToken': 'student'
    };

     print ("dd "+data.toString());
     try {
      var response = await CallApi().postData(data,"/api/Account/Register",0);
      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        // ShowMyDialog.showMsg( body['Message']);
             if(body['Success'] ==true) {
               // GlobalMethods.navigate(context, LoginPage());
               setState(() {
                 _reg_loading=false;
               });
               return true;
             }
             throw body['Message'];
      }
      else{
        // ShowMyDialog.showMsg(body['Message']);
        throw body['Message'];
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
