class PrivateGroup{
   int GroupId ;
   int TeacherId;
   String TeacherName;
   int SubjectId;
   String SubjectName;
   String Title;
   int StudentsCount ;
   int SessionsCount ;
   double   Price;

   PrivateGroup({
     required this.GroupId,
     required this.TeacherId,
     required  this.TeacherName,
     required this.SubjectId,
     required  this.SubjectName,
     required this.Title,
     required this.StudentsCount,
     required  this.SessionsCount,
     required this.Price
   });
   factory  PrivateGroup.fromJson(Map<String, dynamic> json)=>
      PrivateGroup(GroupId:json ['GroupId'],
          TeacherId: json['TeacherId'],
          TeacherName: json['TeacherName'],
          SubjectId: json['SubjectId'],
          SubjectName: json['SubjectName'],
          Title: json['Title'],
          StudentsCount: json['StudentsCount'],
          SessionsCount: json['SessionsCount'],
          Price: json['Price']);
}