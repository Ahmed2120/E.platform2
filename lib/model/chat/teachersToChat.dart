import '../../session/userSession.dart';

class TeachersToChat{

  String TeacherUserId;
  String TeacherName;
  String ProfilePicture;
  String? LastMessage;
  String? LastMessageTime;
  int? UnreadMessCount;
  bool? LastMessageSeen;

  TeachersToChat({ required this.TeacherUserId,required this.TeacherName, required this.ProfilePicture,
    required  this.LastMessage, required this.LastMessageTime,required this.LastMessageSeen,required this.UnreadMessCount });

  factory  TeachersToChat.fromJson(Map<String, dynamic> json)=>
   TeachersToChat(
       TeacherUserId: json['TeacherUserId'],
       TeacherName: json['TeacherName'],
       ProfilePicture:json ['ProfilePicture']==null ? ''
           : UserSession.getURL()+json ['ProfilePicture'],
       LastMessage: json['LastMessage']==null?'.': json['LastMessage'],
       LastMessageTime: json['LastMessageTime'],
       LastMessageSeen: json['LastMessageSeen'],
     UnreadMessCount: json['UnreadMessCount'],
   );

}