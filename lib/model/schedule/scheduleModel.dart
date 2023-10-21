import 'dart:convert';

import 'package:eplatform/model/note/teacherNote.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../api/api.dart';

import '../../widgets/dialogs/alertMsg.dart';
import 'schedule.dart';

mixin ScheduleModel on Model{

  // --------------------Note--------------------------------
  bool _schedule_loading=false;
  bool get scheduleLoading=>_schedule_loading;

  List<Schedule>_scheduleList=[];
  List<Schedule> get scheduleList=>_scheduleList;


  Future fetchSchedule(String ? selectedDay)  async{

    _schedule_loading=true;
    notifyListeners();

    Map<String,dynamic> data={
      'selectedDay' : selectedDay,
    };
    // print(data.toString());

    try {
      var response = await CallApi().getWithBody(data, "/api/Student/GetSchedule",1);
      //  print("body  "+json.decode(response.body).toString());

      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _scheduleList=body.map((e) => Schedule.fromJson(e)).toList();
        ///   print("nameeeee   "+_notes[0].TeacherName);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }

      _schedule_loading=false;
      notifyListeners();
    }
    catch(e){

      _schedule_loading=false;
      notifyListeners();
      print("ee "+e.toString());
    }
  }


}