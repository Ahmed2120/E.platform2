import '../../session/userSession.dart';

class UserTransaction {
  int? id;
  String? description;
  String? descriptionEN;
  double? amount;
  String? walletNo;
  String? toWalletNo;
  int? referenceId;
  int? transactionType;
  bool? isDeleted;
  String? transactionDate;
  String? currencyName;
  String? image;

  UserTransaction(
      {this.id,
        this.description,
        this.descriptionEN,
        this.amount,
        this.walletNo,
        this.toWalletNo,
        this.referenceId,
        this.transactionType,
        this.isDeleted,
        this.transactionDate,
        this.currencyName,
        this.image});

  UserTransaction.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    description = json['Description'];
    descriptionEN = json['DescriptionEN'];
    amount = json['Amount'];
    walletNo = json['WalletNo'];
    toWalletNo = json['ToWalletNo'];
    referenceId = json['ReferenceId'];
    transactionType = json['TransactionType'];
    isDeleted = json['IsDeleted'];
    transactionDate = json['TransactionDate'];
    currencyName = json['CurrencyName'];
    image = json['Image']==null?'':
    UserSession.getURL()+json['Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Description'] = this.description;
    data['DescriptionEN'] = this.descriptionEN;
    data['Amount'] = this.amount;
    data['WalletNo'] = this.walletNo;
    data['ToWalletNo'] = this.toWalletNo;
    data['ReferenceId'] = this.referenceId;
    data['TransactionType'] = this.transactionType;
    data['IsDeleted'] = this.isDeleted;
    data['TransactionDate'] = this.transactionDate;
    data['CurrencyName'] = this.currencyName;
    data['Image'] = this.image;
    return data;
  }
}