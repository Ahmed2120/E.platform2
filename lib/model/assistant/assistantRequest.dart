import '../../session/userSession.dart';

class AssistantRequest{

  int? AssistantRequestId ;
  String? AssistantName;
  String? AssistantImage;

  AssistantRequest({required this.AssistantRequestId,
    required this.AssistantName,
    required this.AssistantImage,
  });
  factory  AssistantRequest.fromJson(Map<String, dynamic> json)=>
      AssistantRequest (
        AssistantRequestId :json['AssistantRequestId'] ,
        AssistantName : json['AssistantName'],
        AssistantImage : json['AssistantImage']==null?'':
        UserSession.getURL()+json['AssistantImage'],
      );
}