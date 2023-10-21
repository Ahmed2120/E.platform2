class CourseLessons{
   int  LessonId ;
    String LessonTitle;
     int VideosCount;
      var Price;
     bool Free;
     bool IsSubscribed;

   CourseLessons({required
      this.LessonId,required this.LessonTitle,required this.VideosCount,
     required this.Price,required this.Free ,required this.IsSubscribed });
   factory  CourseLessons.fromJson(Map<String, dynamic> json)=>
       CourseLessons(
           LessonId: json['LessonId'],
           LessonTitle: json['LessonTitle'],
           VideosCount: json['VideosCount'],
           Price: json['Price'],
           Free: json['Free'],
           IsSubscribed:json['IsSubscribed']
       );

}