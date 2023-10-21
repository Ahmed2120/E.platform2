import '../../session/userSession.dart';

class TeacherGroup{
   int GroupId;
   String GroupName;
   String SubjectPicture;
   double Rate;

   TeacherGroup({ required this.GroupId,required this.GroupName,required this.SubjectPicture,required this.Rate });

   factory  TeacherGroup.fromJson(Map<String, dynamic> json)=>
       TeacherGroup(
           GroupId:json['GroupId'],
           GroupName:json['GroupName'],
           SubjectPicture:UserSession.getURL() +json['SubjectPicture'],
           Rate:json['Rate']);
}