import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlobalMethods{
  static void navigate(BuildContext context, Widget widget){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }));
  }

  static void navigateReplace(BuildContext context, Widget widget){
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }));
  }

  static void navigateReplaceALL(BuildContext context, Widget widget){
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) {
          return widget;
        }),
            (route)=> false
    );
  }

  String dateFormat(DateTime dateTime){
    String format = ' ${getDayName(dateTime)} ${dateTime.day} - ${dateTime.month} - ${dateTime.year}' ;
    return format;
  }

  String formatTimeFromTime(TimeOfDay time){
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String scheduleDateFormat(DateTime dateTime){
    String formattedDate = DateFormat('M/d/yyyy').format(dateTime);
    return formattedDate;
  }

  String formatTimeFromString(String timeString){
    DateTime dateTime = DateTime.parse('2023-07-10 $timeString');
    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, dateTime.minute);
    String formattedTime = DateFormat('HH:mm').format(dateTime);
    return formattedTime;
  }

  String getDayName(DateTime dateTime) {
    var nameDay = DateFormat('EEEE').format(dateTime);
    String name = '';
    switch (nameDay) {
      case "Saturday":
        name = "السبت";
        break;
      case "Sunday":
        name = "الاحد";
        break;
      case "Monday":
        name = "الاثنين";
        break;
      case "Tuesday":
        name = "الثلاثاء";
        break;
      case "Wednesday":
        name = "الاربعاء";
        break;
      case "Thursday":
        name = "الخميس";
        break;
      case "Friday":
        name = "الجمعة";
    }
    return name;
  }

  static bool rtlLang(String languageCode){
    RegExp rtlLanguages = RegExp(r'[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF]+');

    if (rtlLanguages.hasMatch(languageCode[0])) {

      return true;
    } else {
      return false;
    }
  }

  static String showPrice(var price){
    if (price == 0){
      return 'مجاني';
    }
    return price.toString();

  }



}