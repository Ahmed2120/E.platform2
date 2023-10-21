import '../../session/userSession.dart';

class Assistant{

  int? AssistantId ;
  String? AssistantName;
  String? PhoneNumber;
  int? EducationTypeId;
  String? EducationTypeName;
  int? GradeId;
  String? GradeName;
  int? ProgramTypeId;
  String? ProgramTypeName;
  int? CountryId;
  String? CountryName;
  String? Image;

  Assistant({required this.AssistantId,
    required this.AssistantName,required
    this.PhoneNumber,required this.EducationTypeId,
    required this.EducationTypeName,
    required this.GradeId,
    required this.GradeName,
    required this.ProgramTypeId,
    required this.ProgramTypeName,
    required this.CountryId,
    required this.CountryName,
    required this.Image,
  });
  factory  Assistant.fromJson(Map<String, dynamic> json)=>
      Assistant (
        AssistantId :json['AssistantId'] ,
        AssistantName : json['AssistantName'],
        PhoneNumber : json['PhoneNumber'],
        EducationTypeId : json['EducationTypeId'],
        EducationTypeName : json['EducationTypeName'],
        GradeId : json['GradeId'],
        GradeName : json['GradeName'],
        ProgramTypeId : json['ProgramTypeId'],
        ProgramTypeName : json['ProgramTypeName'],
        CountryId : json['CountryId'],
        CountryName : json['CountryName'],
        Image : json['Image']==null?'':
        UserSession.getURL()+json['Image'],
      );
}