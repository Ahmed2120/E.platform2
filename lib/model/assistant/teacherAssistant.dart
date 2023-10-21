import 'package:eplatform/session/userSession.dart';
class AssistantTeachers{
  int Id;
  String Name;
  String ProfileImage;

  AssistantTeachers({ required this.Id,required this.Name,
    required this.ProfileImage, });

  factory  AssistantTeachers.fromJson(Map<String, dynamic> json)=>
      AssistantTeachers(Id: json['Id'],
          Name: json['Name'],
          ProfileImage: json['ProfileImage']==null?'':
          UserSession.getURL()+json['ProfileImage'],);


}