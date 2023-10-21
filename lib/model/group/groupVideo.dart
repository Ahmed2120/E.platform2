class GroupVideo{
    int? GroupVideoId;
     String Title;
     String? VideoUrl;
      var Duration;
    String ClassAt;
    String FromTime;
    String ToTime;

   GroupVideo({ required this.GroupVideoId,required this.Title,required this.VideoUrl,required this.Duration, required this.ClassAt, required this.FromTime, required this.ToTime});
   factory  GroupVideo.fromJson(Map<String, dynamic> json)=>
       GroupVideo(
           GroupVideoId: json['GroupVideoId'],
           Title: json['Title'],
           VideoUrl: json['VideoUrl'],
           Duration: json['Duration'],
           ClassAt: json['ClassAt'],
           FromTime: json['FromTime'],
           ToTime: json['ToTime'],
       );
}