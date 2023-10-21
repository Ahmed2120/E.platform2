class TeacherGroupSessions{
    String Title;
    String GroupName;
    String ClassAt;
    String FromTime;
    String ToTime;

    TeacherGroupSessions({
       required this.Title,required this.GroupName,required this.ClassAt,required this.FromTime,
      required this.ToTime });

    factory  TeacherGroupSessions.fromJson(Map<String, dynamic> json)=>
        TeacherGroupSessions(
            Title: json['Title'],
            GroupName: json['Title'],
            ClassAt: json['ClassAt'],
            FromTime: json['FromTime'],
            ToTime: json['ToTime']);
}