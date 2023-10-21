class NotDeliveredHomework{
   int HomeworkId ;
   String Title;
   String EndDate;
   bool TimeIsUp;

   NotDeliveredHomework({
      required this.HomeworkId,required this.Title, required this.EndDate,required this.TimeIsUp });
   factory  NotDeliveredHomework.fromJson(Map<String,dynamic> json) =>
       NotDeliveredHomework(
           HomeworkId: json['HomeworkId'],
           Title: json['Title'],
           EndDate: json['EndDate'],
           TimeIsUp: json['TimeIsUp']);
}