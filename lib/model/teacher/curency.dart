class SelectedCurrency{
  int Id;
  String Name;
  double value;

  SelectedCurrency({required this.Id,required this.Name,required this.value});

  factory  SelectedCurrency.fromJson(Map<String, dynamic> json)=>
      SelectedCurrency(
          Id: json['Id'],
          Name: json['Name'],
          value: 0.0) ;
}

