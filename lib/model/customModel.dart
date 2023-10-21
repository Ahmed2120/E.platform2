class CustomModel{

 int Id ;
 String Name;
 String NameEN;

 CustomModel({required this.Id, required this.Name ,required this.NameEN});
 factory  CustomModel.fromJson(Map<String, dynamic> json)=>
     CustomModel (
      Id :json['Id'] ,
      Name : json['Name'],
      NameEN:json['NameEN']==null ?'':json['NameEN']
     );
}