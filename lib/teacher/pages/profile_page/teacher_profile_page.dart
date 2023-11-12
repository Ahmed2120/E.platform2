import 'dart:convert';
import 'dart:io';

import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/model/customModel.dart';
import 'package:eplatform/pages/components/custom_elevated_button.dart';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:eplatform/session/userSession.dart';
import 'package:eplatform/widgets/dialogs/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../../api/api.dart';
import '../../../pages/change_password/change_password_page.dart';
import '../../../pages/courses_and_groups/pdfPage.dart';
import '../../../widgets/dialogs/alertMsg.dart';
import '../../../widgets/image_bottom_sheet.dart';
import '../../../widgets/video_dialog.dart';
import '../../../pages/components/show_network_image.dart';
import 'update_teacher_profile_page.dart';

 class TeacherProfilePage extends StatefulWidget {
   const TeacherProfilePage({Key? key}) : super(key: key);

   @override
   State<TeacherProfilePage> createState() => _TeacherProfilePageState();
 }

 class _TeacherProfilePageState extends State<TeacherProfilePage> {

  final link = 'https://www.gggggoolohchgf?jll/';
  late bool _data_loading=false;
  late bool _logout_loading=false;
  late bool _delete_loading=false;

  String  _name ='',_phone='',_email='',_nationalId='',_education_type='' ,_grade='',
      _countryName='', _cityName='',_state='', _imageProfile='' ;

  int ? _stateId, _educationTypeId, _gradeId;

  File? imageFile;

  List<CustomModel>_educationTypes=[];
  CustomModel ? educationType;
  List<CustomModel>_grades=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getTeacheInfo();
  }

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
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), )
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: _data_loading? const Center(child: CircularProgressIndicator()):
                ListView(
                  shrinkWrap: true,
                  children: [
                    Align(alignment: Alignment.center,child: InkWell(onTap: (){
                      // showImgBottomSheet();
                      showModalBottomSheet(
                          context: context,
                          builder: (context)=>ShowImageBottomSheet(onGalleryPick: () async{
                            final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if(picked != null){
                              imageFile = File(picked.path);
                              await uploadImg(imageFile!);
                              _getTeacheInfo();
                            }
                          }, onCameraPick: () async{
                            final picked = await ImagePicker().pickImage(source: ImageSource.camera);
                            if(picked != null){
                              imageFile = File(picked.path);
                              await uploadImg(imageFile!);
                              _getTeacheInfo();
                            }
                          },));
                    }, child: profilePhoto(_imageProfile)),),
                    Align(child: Text(_name, style: Theme.of(context).textTheme.titleMedium,), alignment: Alignment.center,),
                    Text('البريد الالكتروني', style: Theme.of(context).textTheme.titleMedium,),
                    buildContainer(_email, const Icon(Icons.email), context),
                    const SizedBox(height: 3,),
                    Text('رقم الهاتف', style: Theme.of(context).textTheme.titleMedium,),
                    buildContainer(_phone, const Icon(Icons.phone_android), context),
                    const SizedBox(height: 3,),
                    Text('الرقم القومي', style: Theme.of(context).textTheme.titleMedium,),
                    buildContainer(_nationalId, const Icon(Icons.person), context),
                    const SizedBox(height: 3,),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text('الدولة', style: Theme.of(context).textTheme.titleMedium,),
                              buildContainer(_countryName, null, context),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            children: [
                              Text('المحافظة', style: Theme.of(context).textTheme.titleMedium,),
                              buildContainer(_cityName, null, context),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8,),
                        Expanded(
                          child: Column(
                            children: [
                              Text('المنطقة', style: Theme.of(context).textTheme.titleMedium,),
                              buildContainer(_state, null, context),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    Text('السنة الدراسية', style: Theme.of(context).textTheme.titleMedium,),
                   buildContainer(_grade, null, context),

                    const SizedBox(height: 3,),
                    Text('المدرسة', style: Theme.of(context).textTheme.titleMedium,),
                    buildContainer('', null, context),
                    const SizedBox(height: 3,),
                    Text('نوع التعليم', style: Theme.of(context).textTheme.titleMedium,),
                    buildContainer(_education_type, null, context),

                    const SizedBox(height: 8,),
                    InkWell(
                        onTap: () async{
                          GlobalMethods.navigate(context, PdfPage(
                            pdfUrl:'http://africau.edu/images/default/sample.pdf',
                            title:'السرة الذاتية' ,));
                          // PDF().cachedFromUrl('http://africau.edu/images/default/sample.pdf');
                        },
                        child: attachmentContainer('السرة الذاتية', 'assets/icons/pdf.png')),

                    const SizedBox(height: 8,),
                    InkWell(
                        onTap: () async{
                          GlobalMethods.navigate(context, PdfPage(
                            pdfUrl:'http://africau.edu/images/default/sample.pdf',
                            title:'الشهادة' ,));
                          // PDF().cachedFromUrl('http://africau.edu/images/default/sample.pdf');
                        },
                        child: attachmentContainer('الشهادة', 'assets/icons/pdf.png')),

                    const SizedBox(height: 8,),
                    InkWell(
                        onTap: () async{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return VideoDialog(videoUrl: 'https://www.shutterstock.com/shutterstock/videos/1086820415/preview/stock-footage-beautiful-texture-of-big-power-dark-ocean-waves-with-white-wash-aerial-top-view-footage-of.webm');
                            },
                          );
                        },
                        child: attachmentContainer('برومو', 'assets/images/video-marketing (1) 6.png')),

                    const SizedBox(height: 3,),
                    Text('كلمة المرور', style: Theme.of(context).textTheme.titleMedium,),
                    TextButton(onPressed: ()=> GlobalMethods.navigate(context, ChangePasswordPage(phoneNumber: _phone!,)), child: const Text('تغيير كلمة المرور')),
                    const SizedBox(height: 3,),
                    Row(
                      children: [
                        const Icon(Icons.share, size: 15,),
                        Text('كود المشاركة', style: Theme.of(context).textTheme.titleMedium,),
                      ],
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(link, style: Theme.of(context).textTheme.titleSmall,),
                        const SizedBox(width: 30,),
                        InkWell(
                            onTap: (){
                              final value = ClipboardData(text: link);
                              Clipboard.setData(value);
                            },
                            child: const Icon(Icons.copy)),
                      ],
                    ),
                    const SizedBox(height: 3,),
                    Text('شارك الكود على الموقع', style: Theme.of(context).textTheme.titleMedium,),
                    const SizedBox(height: 3,),
                    CustomElevatedButton(title: 'تسجيل الخروج', function: (){
                      showDialog(context: context, barrierDismissible: false, builder: (context)=>
                      ConfirmDialog(title: 'هل انت متأكد من انك تريد تسجيل الخروج', onConfirm: _logout));
                    }),
                    const SizedBox(height: 3,),
                    Align(alignment: Alignment.center, child: TextButton(onPressed: (){
                      showDialog(context: context, barrierDismissible: false, builder: (context)=>
                          ConfirmDialog(title: 'هل انت متأكد من انك تريد حذف الحساب', onConfirm: _deleteAccount));
                    }, child: const Text('حذف الحساب', style: TextStyle(color: Colors.red)))),
                  ],
                ),),
            ),
            Positioned(
              top: deviceSize.height * 0.10,
              left: 20,
              child: InkWell(onTap: ()=> GlobalMethods.navigate(context, UpdateTeacherProfilePage(name: _name, email: _email, phone: _phone, national: _nationalId, grade: _grade, educationType: _education_type, gradeId: _gradeId!, educationTypeId: _educationTypeId!, stateId: _stateId!, school: null)),
                child: const Text('تعديل'),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: ()=> Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Icon(Icons.arrow_forward_ios_sharp,
                        color: AppColors.primaryColor, size: 15,
                      textDirection: TextDirection.ltr,),
                    ),
                  ),
                  const SizedBox(width: 32.0),
                  Text('الملف الشخصي', style: TextStyle(fontSize: deviceSize.height > 500 ? 20 : 15, color: Colors.white, height: 1.5, fontWeight: FontWeight.bold)),
                  IconButton(onPressed: (){}, icon: Image.asset('assets/icons/replace-to-courses.png')),

                  IconButton(onPressed: (){}, icon: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        // borderRadius: BorderRadius.circular(15),
                        shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.keyboard_arrow_down_sharp),
                  )),

                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

  Widget profilePhoto(img){
    return Stack(
      children: [
        _imageProfile==''?
            Image.asset('assets/images/profile.png',height: 80,width: 80,fit: BoxFit.cover,)
            :ShowNetworkImage(img: img,),
        Positioned(child: Image.asset('assets/images/camera.png'), bottom: 0, right: 0,)
      ],
    );
  }

  Widget attachmentContainer(String title, String img) =>
      ListTile(
        leading: Image.asset(img,),
        title: Text(title),
        trailing: const Icon(Icons.edit)
      );

  Widget buildContainer(String txt, Widget? icon, context){
    return SizedBox(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 1
              )
            ]
        ),
        child: Row(
          mainAxisAlignment: icon == null ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Text(txt, style: Theme.of(context).textTheme.titleMedium,),
            const SizedBox(width: 5,),
            icon?? Container()
          ],
        ),
      ),
    );
  }
  changeEducationType(val){
    educationType=val;

    setState(() {

    });
  }

  void _getTeacheInfo() async{
    setState(() {
      _data_loading=true;
    });
    Map session = await UserSession.GetData();

    Map <String,dynamic> data={
      'userId':session['userId']
    };
    final apiLink = UserSession.userRole == '2' ? '/api/Teacher/GetTeacherProfile' : '/api/Assistant/GetAssistantProfile';

    try {
      var response = await CallApi().getWithBody(data,apiLink,1);
      print('=================-===============');
      print(apiLink);
      print(response.body);

      var body = json.decode(response.body);
      if (response != null && response.statusCode == 200) {
        print('=================-===============');
        print(body);
        List e=body['EducationTypes'];
        List g=body['Grades'];
          print('Student body  '+e.toString());

        setState(() {
          _name=body['Name'];
          _phone=body['PhoneNumber'];
          _email=body['Email'];
          _nationalId=body['NationalId'];
          _countryName=body['CountryName'];
          _cityName=body['CityName'];
          _state=body['StateName'];

          _imageProfile =body['ProfilePicture']==null?'': UserSession.getURL()+body['ProfilePicture'];

          _educationTypes=e.map((e) => CustomModel.fromJson(e)).toList();
          _education_type=e[0]['Name'];;

           _grades=g.map((e) => CustomModel.fromJson(e)).toList();
           _grade=g[0]['Name'];
          _stateId = body ['StateId'];
          _educationTypeId = body ['EducationTypeId'];
          _gradeId = body ['GradeId'];

        });
      }
       print(_imageProfile);
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

  void _logout() async{
    setState(() {
      _logout_loading=true;
    });

    try {
      var response = await CallApi().postData(null,"/api/Account/Logout",1);

      var body = json.decode(response.body);
      print('Student body  '+body.toString());
      if (response != null && response.statusCode == 200) {
        // print(body[0]['Student'].toString());
        if(!mounted) return;
        GlobalMethods.navigateReplaceALL(context, LoginPage());
      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _logout_loading=false;
    });
  }

  void _deleteAccount() async{
    setState(() {
      _delete_loading=true;
    });

    try {
      var response = await CallApi().delete(null,"/api/Account/DeleteAccount",1);

      var body = json.decode(response.body);
      print('Student body  '+body.toString());
      if (response != null && response.statusCode == 200) {
        // print(body[0]['Student'].toString());
        if(!mounted) return;
        GlobalMethods.navigateReplaceALL(context, LoginPage());
      }
    }
    catch(e){
      print ('ee '+e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _delete_loading=false;
    });
  }

  uploadImg(File img) async {
    try {
      var response =
      await CallApi().postFile(img, "/api/Account/UpdateProfileImage", 1);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
        final msg = jsonDecode(await response.stream.bytesToString());
        if (!mounted) return;
        ShowMyDialog.showSnack(context, msg['Message'].toString());
      }
    } catch (e) {
      ShowMyDialog.showSnack(context, e.toString());
    }
  }
}