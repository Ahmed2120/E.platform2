import 'dart:convert';
import 'dart:io';

import 'package:eplatform/Professional%20courses/rootprocourses/rootprocorses.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:eplatform/core/utility/global_methods.dart';
import 'package:eplatform/pages/login_page/login_page.dart';
import 'package:eplatform/pages/student/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../api/api.dart';
import '../../session/userSession.dart';
import '../../widgets/dialogs/alertMsg.dart';
import '../../widgets/dialogs/confirm_dialog.dart';

import '../../widgets/image_bottom_sheet.dart';
import '../change_password/change_password_page.dart';
import '../components/custom_elevated_button.dart';
import '../components/custom_title.dart';
import '../components/show_network_image.dart';

class StudentPage extends StatefulWidget {
  const StudentPage({Key? key}) : super(key: key);

  @override
  State<StudentPage> createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  final link = 'https://www.gggggoolohchgf?jll/';

  String? _name = '',
      _phone = '',
      _email = '',
      _nationalId = '',
      _education_type = '',
      _grade = '',
      _countryName,
      _cityName,
      _imageProfile;

  int? _stateId, _educationTypeId, _gradeId;

  File? imageFile;

  bool _data_loading = false;
  bool _logout_loading = false;
  bool _delete_loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getStudentInfo();
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Container(
                  child: _data_loading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: InkWell(
                                  onTap: () {
                                    // showImgBottomSheet();
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            ShowImageBottomSheet(
                                              onGalleryPick: () async {
                                                final picked =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (picked != null) {
                                                  imageFile = File(picked.path);
                                                  await uploadImg(imageFile!);
                                                  _getStudentInfo();
                                                }
                                              },
                                              onCameraPick: () async {
                                                final picked =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                if (picked != null) {
                                                  imageFile = File(picked.path);
                                                  await uploadImg(imageFile!);
                                                  _getStudentInfo();
                                                }
                                              },
                                            ));
                                  },
                                  child: profilePhoto(_imageProfile)),
                            ),
                            Align(
                              child: Text(
                                _name!,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              alignment: Alignment.center,
                            ),
                            Text(
                              'البريد الالكتروني',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            buildContainer(
                                _email!, const Icon(Icons.email), context),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'رقم الهاتف',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            buildContainer(_phone!,
                                const Icon(Icons.phone_android), context),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'الرقم القومي',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            buildContainer(_nationalId?? '',
                                const Icon(Icons.person), context),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'الدولة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      buildContainer(
                                          _countryName!, null, context),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'المحافظة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      buildContainer(_cityName!, null, context),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        'المنطقة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      buildContainer(_cityName!, null, context),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // const SizedBox(height: 3,),
                            // Text('المحافظة', style: Theme.of(context).textTheme.titleMedium,),
                            // buildContainer('القاهرة', null, context),
                            const SizedBox(
                              height: 3,
                            ),

                            // const SizedBox(height: 3,),
                            // Text('المنطقة ', style: Theme.of(context).textTheme.titleMedium,),
                            // buildContainer('التجمع الخامس', null, context),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'السنة الدراسية',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            buildContainer(_grade!, null, context),
                            // const SizedBox(height: 3,),
                            // Text('المدرسة', style: Theme.of(context).textTheme.titleMedium,),
                            // buildContainer('', null, context),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'نوع التعليم',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            buildContainer(_education_type!, null, context),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'كلمة المرور',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            TextButton(
                                onPressed: () => GlobalMethods.navigate(
                                    context,
                                    ChangePasswordPage(
                                      phoneNumber: _phone!,
                                    )),
                                child: const Text('تغيير كلمة المرور')),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.share,
                                  size: 15,
                                ),
                                Text(
                                  'كود المشاركة',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  link,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                InkWell(
                                    onTap: () {
                                      final value = ClipboardData(text: link);
                                      Clipboard.setData(value);
                                    },
                                    child: const Icon(Icons.copy)),
                              ],
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'شارك الكود على الموقع',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            CustomElevatedButton(
                                title: 'تسجيل الخروج',
                                function: () {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) => ConfirmDialog(
                                          title:
                                              'هل انت متأكد من انك تريد تسجيل الخروج',
                                          onConfirm: _logout));
                                }),
                            const SizedBox(
                              height: 3,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) => ConfirmDialog(
                                              title:
                                                  'هل انت متأكد من انك تريد حذف الحساب',
                                              onConfirm: _deleteAccount));
                                    },
                                    child: const Text('حذف الحساب',
                                        style: TextStyle(color: Colors.red)))),
                          ],
                        ),
                ),
              ),
            ),
            Positioned(
              top: deviceSize.height * 0.10,
              left: 20,
              child: InkWell(
                onTap: () => GlobalMethods.navigate(
                    context,
                    UpdateProfilePage(
                        name: _name,
                        email: _email,
                        phone: _phone,
                        national: _nationalId,
                        grade: _grade,
                        educationType: _education_type,
                        gradeId: _gradeId!,
                        educationTypeId: _educationTypeId!,
                        stateId: _stateId!,
                        school: null)),
                child: const Text('تعديل'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: AppColors.primaryColor,
                        size: 15,
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32.0),
                  Text('الملف الشخصي',
                      style: TextStyle(
                          fontSize: deviceSize.height > 500 ? 20 : 15,
                          color: Colors.white,
                          height: 1.5,
                          fontWeight: FontWeight.bold)),
                  IconButton(
                      onPressed: () {
                        GlobalMethods.navigate(
                          context,
                          ROOTPROcORSESScreen(),
                        );
                      },
                      icon: Image.asset('assets/icons/replace-to-courses.png')),
                  IconButton(
                      onPressed: () {},
                      icon: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            // borderRadius: BorderRadius.circular(15),
                            shape: BoxShape.circle),
                        child: Icon(Icons.keyboard_arrow_down_sharp),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profilePhoto(img) {
    return Stack(
      children: [
        _imageProfile == ''
            ? Image.asset(
                'assets/images/profile.png',
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              )
            : ShowNetworkImage(
                img: img,
              ),
        Positioned(
          child: Image.asset('assets/images/camera.png'),
          bottom: 0,
          right: 0,
        )
      ],
    );
  }

  Widget buildContainer(String txt, Widget? icon, context) {
    return SizedBox(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        margin: EdgeInsets.all(3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black26),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 1)
            ]),
        child: Row(
          mainAxisAlignment:
              icon == null ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Text(
              txt,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              width: 5,
            ),
            icon ?? Container()
          ],
        ),
      ),
    );
  }

  void _getStudentInfo() async {
    setState(() {
      _data_loading = true;
    });
    Map session = await UserSession.GetData();

    Map<String, dynamic> data = {'userId': session['userId']};

    try {
      var response = await CallApi()
          .getWithBody(data, "/api/Student/GetStudentProfile", 1);

      var body = json.decode(response.body);
      print('Student body  ' + body.toString());
      if (response != null && response.statusCode == 200) {
        // print(body[0]['Student'].toString());

        setState(() {
          _name = body['Name'];
          _phone = body['PhoneNumber'];
          _email = body['Email'];
          _nationalId = body['NationalId'];
          _education_type = body['EducationTypeName'];
          _grade = body['GradeName'];
          _countryName = body['CountryName'];
          _cityName = body['CityName'];
          _imageProfile =
              body['Image'] == null ? '' : UserSession.getURL() + body['Image'];
          _stateId = body['StateId'];
          _educationTypeId = body['EducationTypeId'];
          _gradeId = body['GradeId'];
        });
      }
      print(_imageProfile);
    } catch (e) {
      print('eee ' + e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _data_loading = false;
    });
  }

  void _logout() async {
    setState(() {
      _logout_loading = true;
    });

    try {
      var response = await CallApi().postData(null, "/api/Account/Logout", 1);

      var body = json.decode(response.body);
      print('Student body  ' + body.toString());
      if (response != null && response.statusCode == 200) {
        // print(body[0]['Student'].toString());
        if (!mounted) return;
        GlobalMethods.navigateReplaceALL(context, LoginPage());
      }
    } catch (e) {
      print('ee ' + e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _logout_loading = false;
    });
  }

  void _deleteAccount() async {
    setState(() {
      _delete_loading = true;
    });

    try {
      var response =
          await CallApi().delete(null, "/api/Account/DeleteAccount", 1);

      var body = json.decode(response.body);
      print('Student body  ' + body.toString());
      if (response != null && response.statusCode == 200) {
        // print(body[0]['Student'].toString());
        if (!mounted) return;
        GlobalMethods.navigateReplaceALL(context, LoginPage());
      }
    } catch (e) {
      print('ee ' + e.toString());
      //  ShowMyDialog.showSnack(context,'ee '+e.toString());
      //   ShowMyDialog.showMsg(context,'ee '+e.toString());
    }
    setState(() {
      _delete_loading = false;
    });
  }

  uploadImg(File img) async {
    try {
      var response =
          await CallApi().postFile(img, "/api/Account/UpdateProfileImage", 1);
      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        final msg = jsonDecode(await response.stream.bytesToString());
        if (!mounted) return;
        ShowMyDialog.showSnack(context, msg['Message'].toString());
      }
    } catch (e) {
      ShowMyDialog.showSnack(context, e.toString());
    }
  }
}
