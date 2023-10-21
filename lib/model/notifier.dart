class Notificationss{
   int Id;
   String Text ;
   bool IsRead ;
    String CreatedAt;

   Notificationss({required this.Id,required this.Text,required this.IsRead,required this.CreatedAt});
   factory  Notificationss.fromJson(Map<String, dynamic> json)=>
       Notificationss(Id: json['Id'],
           Text: json['Text'], IsRead:json ['IsRead'], CreatedAt: json['CreatedAt']);

}