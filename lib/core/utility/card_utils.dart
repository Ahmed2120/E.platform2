import 'package:eplatform/core/utility/enums.dart';
import 'package:flutter/material.dart';

class CardUtils{

  static CardType getCardTypeFrmNumber(String input){
    late CardType cardType;
    if(input.startsWith(RegExp(r'((5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))){
      cardType = CardType.Master;
    }else if(input.startsWith(RegExp(r'[4]'))){
      cardType = CardType.Visa;
    }else if(input.startsWith(RegExp(r'^((506(0|1))|(507(8|9))|(6500))[0-9]{12}$'))){
      cardType = CardType.Verve;
    }else if(input.startsWith(RegExp(r'^3[47][0-9]{13}$'))){
      cardType = CardType.AmericanExpress;
    }else if(input.startsWith(RegExp(r'^6(?:011|5[0-9]{2})[0-9]{12}$'))){
      cardType = CardType.Discover;
    }else{
      cardType = CardType.Invalid;
    }
    return cardType;
  }

  static String getCleanedNumber(String text){
    RegExp regExp = RegExp(r"[^0-9]");
    return text.replaceAll(regExp, '');
  }

  static Widget getCrdIcon(CardType cardType){
    String img = "";
    Icon? icon;

    switch (cardType){
      case CardType.Master :
        img = 'assets/logo/Mastercard.png';
        break;
      case CardType.Visa :
        img = 'assets/logo/Visa.png';
        break;
      case CardType.Verve :
        img = 'assets/logo/verve.png';
        break;
      case CardType.Discover :
        img = 'assets/logo/Discover.png';
        break;
      case CardType.AmericanExpress :
        img = 'assets/logo/American-Express.png';
        break;
      default: 
        icon = const Icon(
          Icons.warning,
          size: 24,
        );
        break;
    }

    return icon ?? Image.asset(img, width: 24, height: 24,);
  }
}