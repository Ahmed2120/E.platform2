import 'package:eplatform/session/userSession.dart';

class Group{
  int GroupId;
  int TeacherId;
  String TeacherName;
  String ? TeacherPicture;
  int SubjectId;
  String SubjectName;
  int Rate;
  int FollowerNo;

  Group({required this.GroupId, required this.TeacherId,required this.TeacherName,
    required this.TeacherPicture,
    required this.SubjectId,
    required this.SubjectName,required this.Rate,required this.FollowerNo});

  factory  Group.fromJson(Map<String, dynamic> json)=>
      Group (
        GroupId:json['GroupId']==null?0:json['GroupId'],
        TeacherId : json['TeacherId'],
        TeacherName : json['TeacherName'] ==null ?'':json['TeacherName'],
        TeacherPicture:json['TeacherPicture']==null ?'': UserSession.getURL()+json['TeacherPicture'],
        SubjectId : json['SubjectId'],
        SubjectName : json['SubjectName'],
        Rate :json['Rate']==null ?0 :json['Rate'] ,
        FollowerNo :json['FollowerNo']==null ?0 :json['FollowerNo'] ,

      );
}