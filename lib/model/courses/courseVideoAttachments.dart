
import 'package:eplatform/session/userSession.dart';

class CourseVideoAttachments{
  int Id;
  String Title;
  String Description;
  String AttachmentUrl;
  String CreatedAt;

  CourseVideoAttachments({ required this.Id, required this.Title, required this.Description,
     required this.AttachmentUrl,required this.CreatedAt});


  factory  CourseVideoAttachments.fromJson(Map<String, dynamic> json)=>
      CourseVideoAttachments (
        Id :json['Id'] ,
        Title : json['Title'],
        Description : json['Description']==null ?'description':json['Description'],
        AttachmentUrl : json['AttachmentUrl']==null ?
        'https://africau.edu/images/default/sample.pdf': UserSession.getURL()+'/'+ json['AttachmentUrl'],
        CreatedAt : json['CreatedAt'],
      );

}