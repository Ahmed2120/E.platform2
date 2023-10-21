
import 'dart:convert';

import 'package:scoped_model/scoped_model.dart';

import '../../api/api.dart';
import '../../widgets/dialogs/alertMsg.dart';
import 'adsDetails.dart';
import 'homeAds.dart';

mixin AdvertisingModel on Model{

  //------------------home ads----------------------------
  bool _homeAdsLoading = false;
  bool get   homeAdsLoading => _homeAdsLoading;

  List<HomeAds> _homeAds = [];
  List<HomeAds> get allHomeAds => _homeAds;

  //------------------ads details----------------------------
  bool _adsDetailsLoading = false;
  bool get   adsDetailsLoading => _adsDetailsLoading;

  AdsDetails? _adsDetails ;
  AdsDetails? get adsDetails => _adsDetails;




  Future  fetchHomeAds()  async{

    _homeAdsLoading=true;
    notifyListeners();
    try {
      var response = await CallApi().getData("/api/Advertisement/GetAdvertisements",1);

       print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        List body = json.decode(response.body);
        _homeAds=body.map((e) =>HomeAds.fromJson(e)).toList();
        print('........... $_homeAds');
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _homeAdsLoading=false;
      notifyListeners();
    }
    catch(e){
      _homeAdsLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }

  Future  fetchAdsDetails(int adsId)  async{

    Map<String, String> data = {
      "adsId" : adsId.toString()
    };

    _adsDetailsLoading=true;
    notifyListeners();
    try {
      var response = await CallApi().getWithBody(data, "/api/Advertisement/GetAdvertisementsDetails",1);

       print(json.decode(response.body));
      if (response != null && response.statusCode == 200) {
        final body = json.decode(response.body);
        _adsDetails= AdsDetails.fromJson(body);
      }
      else{
        ShowMyDialog.showMsg(json.decode(response.body)['Message']);
      }
      _adsDetailsLoading=false;
      notifyListeners();
    }
    catch(e){
      _adsDetailsLoading=false;
      notifyListeners();
      print('ee '+e.toString());
    }
  }


}