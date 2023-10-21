import '../../session/userSession.dart';

class AdsDetails {
  int? Id;
  String Name;
  String? Description;
  String? PathUrl;
  String? Logo;

  AdsDetails({required this.Id, required this.Name, required this.Description, required this.PathUrl, required this.Logo});

  factory AdsDetails.fromJson(Map<String, dynamic> json) => AdsDetails(
        Id: json['Id'],
        Name: json['Name'],
    Description: json['Description'],
    PathUrl: json['PathUrl'],
    Logo: json['Logo'] == null ? '' : UserSession.getURL() + json['Logo'],
      );
}
