import 'package:intl/intl.dart';

class ConvertDateToTxt{
  static String dateConverter(String myDate) {
    String date='';
    try {

      DateTime convertedDate =
      DateFormat("MM/dd/yyyy hh:mm a").parse(myDate.toString());
    //  print('date  '+ myDate);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(now.year, now.month, now.day - 1);
      final tomorrow = DateTime(now.year, now.month, now.day + 1);

      final dateToCheck = convertedDate;

      final checkDate = DateTime(
          dateToCheck.year, dateToCheck.month, dateToCheck.day);

      if (checkDate == today) {
        date = 'اليوم';
      } else if (checkDate == yesterday) {
        date = 'أمس';
      } else if (checkDate == tomorrow) {
        date = 'Tomorrow';
      } else {
        date =  DateFormat("MM/dd/yyyy").format(convertedDate);
      }
    }catch(e){
      print(e.toString());
    }


    return date;

  }

}