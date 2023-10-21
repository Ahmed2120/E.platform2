class  TeacherGroups{
     int GroupId ;
     String Title;
     int AvailablePlaces;
     int Limit;
     int SessionsCount;
     var Price;
     bool IsSubscribed;

     TeacherGroups({ required this.GroupId,required this.Title,
       required this.AvailablePlaces,required this.Limit,
       required this.SessionsCount,required this.Price,required this.IsSubscribed});

     factory  TeacherGroups.fromJson(Map<String, dynamic> json)=>
         TeacherGroups(
             GroupId: json['GroupId'],
             Title: json['Title'],
             AvailablePlaces: json['AvailablePlaces'],
             Limit: json['Limit'],
             SessionsCount: json['SessionsCount'],
             Price: json['Price'],
             IsSubscribed:json['IsSubscribed']
         );

}