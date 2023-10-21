import 'package:eplatform/session/userSession.dart';

class ChatGroupMessage{
   String Text;
   String SentByName;
   String SentByPicture;
   bool IsSender;
   String SentAt;

  ChatGroupMessage({ required this.Text,required this.SentByName,required this.SentByPicture,
    required this.IsSender,required this.SentAt });

  factory  ChatGroupMessage.fromJson(Map<String, dynamic> json)=>
      ChatGroupMessage(
          Text: json['Text']==null?'.':json['Text'],
          SentByName: json['SentByName'],
          SentByPicture:json['SentByPicture']==null?'':UserSession.getURL()+ json['SentByPicture'],
          IsSender: json['IsSender'],
          SentAt: json['SentAt']);
}