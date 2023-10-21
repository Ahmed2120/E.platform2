import 'package:eplatform/session/userSession.dart';

class ImgCustomModel{

 int Id ;
 String Image;

 ImgCustomModel({required this.Id, required this.Image});
 factory  ImgCustomModel.fromJson(Map<String, dynamic> json)=>
     ImgCustomModel (
      Id :json['Id'] ,
       Image : UserSession.getURL()+json['Image'],
     );
}