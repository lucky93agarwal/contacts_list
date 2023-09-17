import 'dart:math';
import 'dart:ui';

import 'package:flutter_contacts/contact.dart';

class GetData {
  static String getAddress(Contact _contacts) {
    return (_contacts.addresses[0].neighborhood.length > 0
            ? (_contacts.addresses[0].neighborhood + ", ")
            : "") +
        (_contacts.addresses[0].street.length > 0
            ? (_contacts.addresses[0].street + ", ")
            : "") +
        (_contacts.addresses[0].city.length > 0
            ? (_contacts.addresses[0].city + ", ")
            : "") +
        (_contacts.addresses[0].postalCode.length > 0
            ? _contacts.addresses[0].postalCode + ", "
            : "") +
        (_contacts.addresses[0].state.length > 0
            ? _contacts.addresses[0].state + ", "
            : "") +
        (_contacts.addresses[0].country.length > 0
            ? _contacts.addresses[0].country
            : "");
  }

  static  String getMobileNo(Contact contact){
    String mobile = "";
    if(contact.phones.length >1){
      for(int i=0;i< contact.phones.length;i++){
        if(i== contact.phones.length-1){
          mobile = mobile + contact.phones[i].number;
        }else{
          mobile = mobile + contact.phones[i].number+"\n";
        }
      }
    }else if(contact.phones.length == 1){
      mobile = mobile + contact.phones[0].number;
    }
    return mobile;
  }
  static String getUserName(Contact contact){
    return contact.displayName.substring(0,1).toUpperCase()+
        contact.displayName.substring(1,contact.displayName.length);
  }
  static String getUserNameFirstLatter(Contact contact){
    return contact.displayName.substring(0,1).toUpperCase();
  }
  static bool checkAddress(Contact contact){
    return contact.addresses.length>0?true:false;
  }

  static bool checkPhotoOrThumbnail(Contact contact){
    return contact.photoOrThumbnail != null?true:false;
  }


  static Color randomColorDark() {
    final List<Color> _alreadyUsedColors = [];
    Color newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    while (_alreadyUsedColors.contains(newColor)) {
      newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    }
    _alreadyUsedColors.add(newColor);
    return newColor;
  }

  static Color randomColor() {
    final List<Color> _alreadyUsedColors = [];
    Color newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.3);

    while (_alreadyUsedColors.contains(newColor)) {
      newColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(0.3);
    }
    _alreadyUsedColors.add(newColor);
    return newColor;
  }
}
