import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:eplatform/pages/courses_and_groups/book_appointment_page.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/api.dart';
import '../../core/utility/app_colors.dart';
import '../../core/utility/global_methods.dart';
import '../../model/customModel.dart';
import '../../widgets/custom_stack.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'component/book_field.dart';
import 'component/drop_down.dart';

class BookNotePage extends StatefulWidget {
   BookNotePage({ required this.NotebookId, required this.NotebookName,Key? key}) : super(key: key);
  int NotebookId;
  String NotebookName;

  @override
  State<BookNotePage> createState() => _BookNotePageState();
}

class _BookNotePageState extends State<BookNotePage> {

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _yearController = TextEditingController();
  final _addressController = TextEditingController();
  final _noteNameController = TextEditingController();
  final _qntController = TextEditingController(text: '1');

  bool _loading=false;
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
  bool _country_loading=false;
  bool _city_loading=false;
  bool _area_loading=false;
  String  _name ='',_phone='',_email='' ,_grade='' ;
  bool _data_loading=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _getUserData();
    _noteNameController.text = widget.NotebookName;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomStack(
        pageTitle: 'المذكرات',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child:
              _data_loading ?Center(child: CircularProgressIndicator()):
              ListView(
                shrinkWrap: true,
                children: [
                  Align(alignment: Alignment.center, child: Text('حجز المذكرة', style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center,)),
                  Text('البريد الإلكتروني',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 5,),
                  bookField(controller: _emailController, hintText: 'البريد الإلكتروني', ),
                  const SizedBox(height: 5,),
                  Text('رقم التليفون', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 5,),
                  bookField(controller: _phoneController, hintText: 'رقم التليفون', ),
                  const SizedBox(height: 5,),
                  Text('السنة الدراسية', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 5,),
                  bookField(controller: _yearController, hintText: 'السنة الدراسية', ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text('الدولة', style: Theme.of(context).textTheme.titleSmall),
                            _country_loading?CircularProgressIndicator():
                            DropDownNote(list: countries,
                              onChange: changeCountries,
                              hintText: '', item: country,),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                          children: [
                            Text('المحافظة', style: Theme.of(context).textTheme.titleSmall),
                            _city_loading?CircularProgressIndicator():
                            DropDownNote(list: cities, onChange: changeCities, hintText: '', item: city,),
                          ],
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                          children: [
                            Text('المنطقة', style: Theme.of(context).textTheme.titleSmall),
                            _area_loading?CircularProgressIndicator():
                            DropDownNote(list: areas,
                              onChange: changeAreas, hintText: '', item: area,),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text('العنوان', style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: 5,),
                  bookField(controller: _addressController, hintText: '', ),
                  const SizedBox(height: 5,),
                  Align(alignment: Alignment.center, child: Text('عدد النسخ', style: Theme.of(context).textTheme.titleSmall)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _qntController.text =
                              (int.parse(_qntController.text) + 1).toString();
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          child: Icon(Icons.add),
                        ),
                      ),
                      SizedBox(
                          width: deviceSize.width * 0.5,
                          child: TextField(
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp('[0-9]'),
                              ),
                            ],
                            onEditingComplete: () {
                              if (_qntController.text.isEmpty) {
                                _qntController.text = '1';
                              }
                              FocusScope.of(context).unfocus();
                            },
                            controller: _qntController,
                          )),
                      InkWell(
                        onTap: () {
                          if (int.parse(_qntController.text) <= 1) return;
                          _qntController.text =
                              (int.parse(_qntController.text) - 1).toString();
                        },
                        child: const CircleAvatar(
                          radius: 15,
                          backgroundColor: Color(0xFF939393),
                          foregroundColor: Colors.white,
                          child: Icon(Icons.remove),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                 _loading==true?
                     Center(child: CircularProgressIndicator()):
                 buildElevatedButton('احجز نسختك الان', (){
                    _book();
                  }),
                  const SizedBox(height: 12,),
                ],
              ),
            ),



          ],
        ),
      ),
    );
  }

  ElevatedButton buildElevatedButton(String title, Function function) {
    return ElevatedButton(
      onPressed: () => function(),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        minimumSize: const Size(40, 40),
      ),
      child: Text(title),
    );
  }

  changeCountries(value){
    country=value;
    setState(() {
      city='';
      area='';
      cities=[];
      areas=[];
      _country_index = _countries.indexWhere((item) => item.Name== value);
      final countryId = _countries.firstWhere((item) => item.Name== value).Id;
      _getCities(countryId);
    });
    print ("country index  "+_country_index.toString());
  }

  changeCities(value){

    setState(() {
      city=value;
      area='';
      _city_index = _cities.indexWhere((item) => item.Name== value);
      _getAreaes(_cities[_city_index!].Id);
    });
    print ("city index  "+_city_index.toString());
  }

  changeAreas(value){
    setState(() {
      area=value;
      areas=[];
      _area_index = _areas.indexWhere((item) => item.Name== value);
    });

  }

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

  void _getCities(int countryId) async{

    setState(() {
      _city_loading=true;
    });
    Map <String, dynamic>data={
      "countryId" :countryId.toString()
    };
    // print ("country_id "+_countries[_country_index!].Id.toString());
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
      _city_loading=false;
    });
  }

  void _getAreaes(int city_id) async{
    setState(() {
      _area_loading=true;
    });
    Map <String, dynamic>data={
      "cityId" :city_id.toString()
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/state/get-states",0);
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);

        _areas=body.map((e) => CustomModel.fromJson(e)).toList();

        areas= _areas.map((CustomModel) => CustomModel.Name).toList();

        _area_index = areas.indexOf(areas.firstWhere((element) => element == area));

      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _area_loading=false;
    });
  }

  void _book()  async {
    setState(() {
      _loading=true;
    });

    Map data={
      'Email':_emailController.text.toString(),
      'PhoneNumber':_phoneController.text.toString(),
      'StateId':_areas[_area_index!].Id.toString(),
      'Address':_addressController.text.toString() ,
      'CopiesNo': int.parse(_qntController.text).toString(),
      'NotebookId': widget.NotebookId.toString(),
    };


    try {
      var response = await CallApi().postData(data,"/api/Notebook/BookNotebook",1);
      var body = json.decode(response.body);
      print ("body "+body.toString());

      if (response != null && response.statusCode == 200) {
        if(body['Success'] ==true) {
          ShowMyDialog.showMsg('تم حجز المذكرة بنجاح');
        //  Navigator.of(context).pop();
        }
      }
      else{
        ShowMyDialog.showMsg(body['Message']);
      }
      setState(() {
        _loading=false;
      });
    }
    catch(e){
      setState(() {
        _loading=false;
      });
       ShowMyDialog.showMsg('ee '+e.toString());
      print('ee '+e.toString());

    }



  }

  _getUserData() async{
    setState(() {
      _data_loading=true;
    });
    Map session = await UserSession.GetData();

    Map <String,dynamic> data={
      'userId':session['userId']
    };

    try {
      var response = await CallApi().getWithBody(data,"/api/Student/GetStudentProfile",1);

      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
         print(body.toString());

        setState(() {
          _name=body['Name'];
          _phone=body['PhoneNumber'];
          _email=body['Email'];
          _grade=body['GradeName'];
         country=body['CountryName'];
         city=body['CityName'];
         area=body['StateName'];

          _emailController.text=_email;
          _phoneController.text=_phone;
          _yearController.text=_grade;

          _getCountry();
          _getCities(body['CountryId']);
          _getAreaes(body['CityId']);

        //  _city_index = _cities.indexWhere((item) => item.Name== city);

        });
      //   _getAreaes(_cities[_city_index!].Id);
      }

    }
    catch(e){
      print ('eee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _data_loading=false;
    });
  }

}

