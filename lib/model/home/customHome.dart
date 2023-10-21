import '../../session/userSession.dart';

class CustomHome{
   int Id ;
    String Name;
   String Image;

   CustomHome({ required this.Id,required this.Name,required this.Image});

   factory  CustomHome.fromJson(Map<String, dynamic> json)=>
       CustomHome(
           Id: json['Id'],
           Name: json['Name']==null ?json['Title'] :json['Name'],
           Image: json['Image']==null?'':UserSession.getURL()+ json['Image'] );

}