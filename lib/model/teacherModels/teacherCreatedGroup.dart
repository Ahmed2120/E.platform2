class TeacherCreatedGroup{

   int GroupId;
   String Title;
   int StudentsCount;
   int SessionsCount;

   TeacherCreatedGroup({required
      this.GroupId, required this.Title,required this.StudentsCount,required this.SessionsCount });
    factory TeacherCreatedGroup.fromJson(Map<String,dynamic> json)=>
        TeacherCreatedGroup(
            GroupId: json['GroupId'],
            Title: json['Title'], StudentsCount: json['StudentsCount'],
            SessionsCount: json['SessionsCount']);

}