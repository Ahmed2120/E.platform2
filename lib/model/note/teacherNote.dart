class TeacherNotebooks{
   int NotebookId ;
   String TeacherName;
   String GradeName;
    String SubjectName;
    String Title;
    double Price;

   TeacherNotebooks({required this.NotebookId,required this.TeacherName,
     required this.GradeName,
     required this.SubjectName,required this.Title,required this.Price });
   factory  TeacherNotebooks.fromJson(Map<String, dynamic> json)=>
       TeacherNotebooks(
           NotebookId: json['NotebookId'],
           TeacherName: json['TeacherName'],
           GradeName: json['GradeName'],
           SubjectName: json['SubjectName'],
           Title:json['Title'] ,
           Price: json['Price']);

}