import 'package:eplatform/session/userSession.dart';
class AssistantTeachers{
  int Id;
  String Name;
  String ProfileImage;
  int status;

  AssistantTeachers({ required this.Id,required this.Name,
    required this.ProfileImage, required this.status});

  factory  AssistantTeachers.fromJson(Map<String, dynamic> json)=>
      AssistantTeachers(Id: json['Id'],
          Name: json['Name'],
          ProfileImage: json['ProfileImage']==null?'':
          UserSession.getURL()+json['ProfileImage'],
      status: json['status']?? 0);


}