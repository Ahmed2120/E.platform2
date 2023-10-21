class CourseVideoComments{

  int Id;
  String Comment;
  String CreatedAt;
  var CreatedById;
  String UserName;

  CourseVideoComments({required this.Id,required this.Comment,required this.CreatedAt,
    required this.CreatedById ,required this.UserName });

  factory  CourseVideoComments.fromJson(Map<String, dynamic> json)=>
      CourseVideoComments (
        Id :json['Id'] ,
        Comment : json['Comment'],
        CreatedAt : json['CreatedAt'],
        CreatedById : json['CreatedById'] ==null ?'': json['CreatedById'],
          UserName:json['UserName']
      );
}