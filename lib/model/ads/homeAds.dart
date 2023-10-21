import '../../session/userSession.dart';

class HomeAds{
  int? Id;
  String Name;
  String? Image;

  HomeAds({ required this.Id,required this.Name,required this.Image});
  factory  HomeAds.fromJson(Map<String, dynamic> json)=>
      HomeAds(
        Id: json['Id'],
        Name: json['Name'],
        Image: json['Image'] == null ? '' : UserSession.getURL()+json['Image'],
      );
}