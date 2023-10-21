class GroupPrice{
   int CurrencyId;
   String CurrencyName;
    double Price;

   GroupPrice({ required this.CurrencyId,required this.CurrencyName,required this.Price});
   factory GroupPrice.fromJson(Map<String, dynamic> json)=>
       GroupPrice(CurrencyId: json['CurrencyId'], CurrencyName: json['CurrencyName'], Price: json['Price']);
}