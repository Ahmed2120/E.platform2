import '../../session/userSession.dart';

class ChatGroup{
  int ChatGroupId;
  String ChatGroupName;
  String GroupImage;
  String LastSenderName;
  String LastMessage;
  String LastMessageTime;
  bool LastMessageSeen;
  int? UnreadMessagesCount;

  ChatGroup({ required this.ChatGroupId, required this.ChatGroupName,required this.GroupImage,
    required this.LastSenderName,
     required this.LastMessage,required this.LastMessageTime, required this.LastMessageSeen, required this.UnreadMessagesCount});
  factory  ChatGroup.fromJson(Map<String, dynamic> json)=>
      ChatGroup(
          ChatGroupId: json['ChatGroupId'],
          ChatGroupName: json['ChatGroupName'],
          GroupImage: json['GroupImage'] ==null ?''
              : UserSession.getURL()+json['GroupImage'],
          LastSenderName:json['LastSenderName']==null?'':json['LastSenderName'],
          LastMessage: json['LastMessage']==null ?'':json['LastMessage'],
          LastMessageTime: json['LastMessageTime']==null?'':json['LastMessageTime'],
          LastMessageSeen: json['LastMessageSeen'],
        UnreadMessagesCount: json['UnreadMessagesCount'],
      );

}