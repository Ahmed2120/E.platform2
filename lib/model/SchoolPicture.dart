class SchoolPicture{
  String Picture;

  SchoolPicture({required this.Picture});
  factory  SchoolPicture.fromJson(Map<String, dynamic> json)=>
      SchoolPicture (

          Picture:json['Picture']==null ?'https://www.naperville203.org/'
              'cms/lib/IL01904881/Centricity/Shared/school%20exterior%20'
              'photos/Elmwood%20exterior%20web%20profile.jpg':json['Picture']

      );
}