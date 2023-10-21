import 'package:eplatform/session/userSession.dart';
class Teachers{
   int Id;
   String Name;
   String ProfileImage;
   String Subjects;
    double Rate;
   late  int FollowersCount;

   Teachers({ required this.Id,required this.Name,
     required this.ProfileImage,required this.Subjects,
     required this.Rate,
     required this.FollowersCount });

   factory  Teachers.fromJson(Map<String, dynamic> json)=>
       Teachers(Id: json['Id'],
           Name: json['Name'],
           ProfileImage: json['ProfileImage']==null?'':
            UserSession.getURL()+json['ProfileImage'],
           Subjects: json['Subjects'],
           Rate: json['Rate'],
           FollowersCount: json['FollowersCount']==null?0:json['FollowersCount']);


}