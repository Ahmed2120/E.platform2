
class Subject{
  int Id;
  String Name;
  String ? Image;

  Subject({ required this.Id, required this.Name, required this.Image});
  factory  Subject.fromJson(Map<String, dynamic> json)=>
      Subject (
          Id :json['Id'] ,
          Name : json['Name'],
          Image:json['Image']==Null ?'':json['Image']

      );


}