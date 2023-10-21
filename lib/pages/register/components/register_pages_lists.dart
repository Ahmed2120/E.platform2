import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:eplatform/core/utility/app_colors.dart';
import 'package:flutter/material.dart';

import '../../components/custom_dotted_border.dart';
import 'confirm_pass_field.dart';
import 'drop_down.dart';
import 'multi_select_Dwon.dart';
import 'register_field.dart';
import 'package:path/path.dart';

List<Widget> firstPage(
        _nameController,
        _phoneController,
        _idController,
        _emailController,
        _passwordController,
        _confirmPasswordController,
        gender,
    {required changeGender, required toggleConfirmPass, required togglePass, required isPassword, required isConfirmPassword, }) =>
    [
      RegisterField(controller: _nameController, hintText: 'الاسم',),
      const SizedBox(height: 12,),
      RegisterField(controller: _phoneController, hintText: 'رقم الهاتف',),
      const SizedBox(height: 12,),
      RegisterField(controller: _idController, hintText: 'الرقم القومي', required: false,),
      const SizedBox(height: 12,),
      RegisterField(controller: _emailController, hintText: 'البريد الالكتروني', required: false,),
      const SizedBox(height: 12,),
      RegisterField(controller: _passwordController, isPassword: true, changePassword: isPassword,
        togglePass: ()=>togglePass(), hintText: 'كلمة المرور',),
      const SizedBox(height: 12,),
      ConfirmPassField(controller: _confirmPasswordController, isConfirmPassword: isConfirmPassword, passwordController: _passwordController, hintText: 'تاكيد كلمة المرور',
        togglePass: ()=>toggleConfirmPass(),),
      const SizedBox(height: 12,),
      Directionality(
        textDirection: TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: RadioListTile(
                    title: Text('انثى'),
                    value: gender,
                    groupValue: 2,
                    onChanged: (value) {changeGender(2);})),
            Expanded(
                child: RadioListTile(
                    title: Text('ذكر'),
                    value: gender,
                    groupValue: 1,
                    onChanged: (value) {changeGender(1);})),
            Text(
              'النوع ',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      )
    ];

List<Widget> secondPage({
  required List<String> countries,
  required changeCountry,
  required String? country,
  required List<String> cities,
  required changeCity,
  required String? city,
  required List<String> areas,
  required changeArea,
  required String? area,
}) =>
    [

      DropDownRegister(countries, changeCountry, country, 'الدولة'),
      const SizedBox(height: 12,),
      DropDownRegister(cities, changeCity, city, 'المدينة'),
      const SizedBox(height: 12,),
      DropDownRegister(areas, changeArea, area, 'المنطقة'),
    ];

List<Widget> studentThirdPage({
  required List<String> educationTypeList,
  required changeEducationType,
  required String? educationType,
  required List<String> educationLevelList,
  required changeEducationLevel,
  required String? educationLevel,
  required List<String> educationPrograms,
  required changeEducationPrograms,
  required String? educationProgram,
}) =>
    [
      DropDownRegister(educationTypeList, changeEducationType, educationType, 'نوع التعليم'),
      const SizedBox(height: 12,),
      DropDownRegister(educationPrograms, changeEducationPrograms, educationProgram, 'نوع المنهج'),
      const SizedBox(height: 12,),
      DropDownRegister(educationLevelList, changeEducationLevel, educationLevel, 'المرحلة الدراسية'),
    ];

List<Widget> teacherThirdPage({
  required List<String> educationTypeList,
  required changeEducationType,
  required String? educationType,
  required List<String> educationLevelList,
  required changeEducationLevel,
  required List<String> selectedEducationLevels,
  required List<String> subjects,
  required changeSubject,
  required List<String> selectedSubjects,
  required List<String> educationPrograms,
  required changeEducationPrograms,
  required List<String> selectEdducationPrograms,
  required bool hasProgram,
}) =>
    [
      DropDownRegister(educationTypeList, changeEducationType, educationType, 'نوع التعليم'),
      if(hasProgram) const SizedBox(height: 12,),
      if(hasProgram) MultiSelectDdown(educationPrograms, changeEducationPrograms, selectEdducationPrograms, 'نوع المنهج'),
      const SizedBox(height: 12,),
      MultiSelectDdown(educationLevelList, changeEducationLevel, selectedEducationLevels, 'السنة الدراسية'),
      const SizedBox(height: 12,),
      MultiSelectDdown(subjects, changeSubject, selectedSubjects, 'المادة'),
    ];

List<Widget> teacherFourthPage({required Function getCV,
  required Function getCertificate, required Function getPromo,
  required File? certificate, required File? cv, required File? promo,
})=> [
  Text('رفع السيرة الذاتية', style: TextStyle(color: Colors.black),),
  const SizedBox(height: 5,),
  InkWell(
    onTap: ()=> getCV(),
    child: CustomDottedBorder(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 32,),
          Image.asset('assets/images/upload.png'),
          Text(cv != null ? basename(cv.path) : 'تصفح'),
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
          Text(certificate != null ? basename(certificate.path) : 'تصفح'),
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
          Text(promo != null ? basename(promo.path) : 'تصفح'),
        ],
      ),
    ),
  ),
];
