class TeacherCreatedNote{
    int NotebookId;
    String Title;
    String SubjectName;
    double Price;

    TeacherCreatedNote({required this.NotebookId,required this.Title,required this.SubjectName,required this.Price});
    factory  TeacherCreatedNote.fromJson(Map<String, dynamic> json)=>
        TeacherCreatedNote(NotebookId: json['NotebookId'],
            Title: json['Title'],
            SubjectName: json['SubjectName'],
            Price: json['Price']==null?0.0 :  json['Price']);

}