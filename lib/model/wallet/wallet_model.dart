import 'dart:convert';
import 'package:eplatform/model/wallet/userTransaction.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'user_balance.dart';

mixin WalletModel on Model{

  bool _balance_loading=false;
  bool get  balanceLoading=>_balance_loading;

  UserBalance? _balance;
  UserBalance? get balance => _balance;

  bool _usertransaction_loading=false;
  bool get  usertransactionLoading=>_usertransaction_loading;

  List<UserTransaction> _userTransactionList = [];
  List<UserTransaction> get userTransactionList => _userTransactionList;

  Future fetchUserBalance() async{
    _balance_loading=true;
    notifyListeners();


    try {
      var response = await CallApi().getData( "/api/Transaction/GetUserBalance", 1);
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        _balance = UserBalance.fromJson(body);
      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _balance_loading=false;
      notifyListeners();
    }
    catch(e){
      _balance_loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future fetchUserTransaction() async{
    _usertransaction_loading=true;
    notifyListeners();


    try {
      var response = await CallApi().getData( "/api/Transaction/GetUserTransaction", 1);
        print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        var body = json.decode(response.body);
        List passed=body;
        _userTransactionList=passed.map((e) => UserTransaction.fromJson(e)).toList();

      }
      else {
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _usertransaction_loading=false;
      notifyListeners();
    }
    catch(e){
      _usertransaction_loading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }


}