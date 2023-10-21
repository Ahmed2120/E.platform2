
import '../../session/userSession.dart';

class SingleChatMessage{
  String SentToName;
  String SentToPicture;
  String SentFromName;
  String SentFromPicture;
  bool IsSender;
  String Text;
  String SentAt;

  SingleChatMessage({required this.SentToName,required this.SentToPicture,required this.SentFromName,
    required this.SentFromPicture,required this.IsSender,required this.Text,required this.SentAt});

  factory SingleChatMessage.fromJson(Map<String, dynamic> json)=>
      SingleChatMessage(
          SentToName: json['SentToName'],
          SentToPicture: json['SentToPicture']==null ?'':
                              UserSession.getURL()+json['SentToPicture'],
          SentFromName: json['SentFromName'],
          SentFromPicture: json['SentFromPicture']==null ?'':
                                      UserSession.getURL()+json['SentFromPicture'],
          IsSender:json['IsSender'],
          Text: json['Text']==null?'.':json['Text'],
          SentAt: json['SentAt']);
}