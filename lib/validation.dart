

import 'package:meeting_management/constant.dart';

extension ExtensionString on String{

  bool get isNotNullValidation{
    return isNotEmpty? true:false;
  }

  bool get isNotName{
    final nameRegExp = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]');
    return nameRegExp.hasMatch(this);
  }

  bool get isMobileNumber{
    final mobileRegExp = RegExp(r'^((\+|00)?98|0?)?(9[0-9]{9})$');
    return mobileRegExp.hasMatch(convertNumberWithLanguage(languageEn: true));
  }


  bool get isEmail {
    final emailRegExp =  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isPassword {
    RegExp regExpOne =  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\\$&*~]).{8,}$');
    RegExp regExpTwo =  RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
    return !regExpOne.hasMatch(this) && !regExpTwo.hasMatch(this);
  }

  bool isDropdownChoice(String? value, String? firstItem ){
    if(value == null || value == firstItem!){
      return false;
    }
    return true;
  }

}

