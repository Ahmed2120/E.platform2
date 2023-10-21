import 'package:eplatform/session/userSession.dart';

class PriceCustomModel{

  int CurrencyId ;
  String CurrencyName ;
  double Price;

  PriceCustomModel({required this.CurrencyId, required this.CurrencyName, required this.Price, });
  factory  PriceCustomModel.fromJson(Map<String, dynamic> json)=>
      PriceCustomModel (
        CurrencyId :json['CurrencyId'] ,
        CurrencyName :json['CurrencyName'] ,
        Price :json['Price'] ,
      );
}