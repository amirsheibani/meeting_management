

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:characters/src/extensions.dart';
import 'package:intl/intl.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:shamsi_date/shamsi_date.dart';
const bool develop = true;

const String developUrl = '172.16.4.126';
const String developPort = '9090';
const String developSchema = 'http';

// const String developUrl = 'aryacrm.behpardaz.net';
// const String developPort = '80';
// const String developSchema = 'http';

const String publishURL = 'aryacrm.behpardaz.net';
const String publishPort = '4443';
const String publishSchema = 'https';

const String schema = develop ? developSchema : publishSchema;
const String url = develop ? developUrl : publishURL;
const String port = develop ? developPort : publishPort;

const String path = '$schema://$url:$port';

const String interiorScreen = '0x10';
const String languageCode = '0x11';
const String countryCode = '0x12';
const String themeMode = '0x13';
const String themeAutoChange = '0x14';

const String interiorScreenTrue = '0x20';
const String interiorScreenFalse = '0x21';

const String languageCodeEn = '0x30';
const String languageCodeFa = '0x31';

const String countryCodeUS = '0x40';
const String countryCodeIR = '0x41';

const String themeModeDark = '0x50';
const String themeModeLight = '0x51';

const String themeAutoChangeTrue = '0x60';
const String themeAutoChangeFalse = '0x61';


extension HourExtensions on int{
  int convertHalfFormatHour() {
    if (this <= 12) {
      return this;
    } else {
      return this % 12;
    }
  }
}
// }
// extension PersianStringExtensions on String {
//   String convertNumberWithLanguage(){
//     if(LanguageState.language == Language.en){
//       if (this.isEmpty) {
//         return this;
//       }
//       var x = this;
//       x = x.replaceAll('\u06F0', '0');
//       x = x.replaceAll('\u06F1', '1');
//       x = x.replaceAll('\u06F2', '2');
//       x = x.replaceAll('\u06F3', '3');
//       x = x.replaceAll('\u06F4', '4');
//       x = x.replaceAll('\u06F5', '5');
//       x = x.replaceAll('\u06F6', '6');
//       x = x.replaceAll('\u06F7', '7');
//       x = x.replaceAll('\u06F8', '8');
//       x = x.replaceAll('\u06F9', '9');
//
//       x = x.replaceAll('\u0660', '0');
//       x = x.replaceAll('\u0661', '1');
//       x = x.replaceAll('\u0662', '2');
//       x = x.replaceAll('\u0663', '3');
//       x = x.replaceAll('\u0664', '4');
//       x = x.replaceAll('\u0665', '5');
//       x = x.replaceAll('\u0666', '6');
//       x = x.replaceAll('\u0667', '7');
//       x = x.replaceAll('\u0668', '8');
//       x = x.replaceAll('\u0669', '9');
//
//       return x;
//     }else{
//       if (this.isEmpty) {
//         return this;
//       }
//
//       var x = this;
//       x = x.replaceAll('0', '\u06F0');
//       x = x.replaceAll('1', '\u06F1');
//       x = x.replaceAll('2', '\u06F2');
//       x = x.replaceAll('3', '\u06F3');
//       x = x.replaceAll('4', '\u06F4');
//       x = x.replaceAll('5', '\u06F5');
//       x = x.replaceAll('6', '\u06F6');
//       x = x.replaceAll('7', '\u06F7');
//       x = x.replaceAll('8', '\u06F8');
//       x = x.replaceAll('9', '\u06F9');
//
//       x = x.replaceAll('\u0660', '\u06F0');
//       x = x.replaceAll('\u0661', '\u06F1');
//       x = x.replaceAll('\u0662', '\u06F2');
//       x = x.replaceAll('\u0663', '\u06F3');
//       x = x.replaceAll('\u0664', '\u06F4');
//       x = x.replaceAll('\u0665', '\u06F5');
//       x = x.replaceAll('\u0666', '\u06F6');
//       x = x.replaceAll('\u0667', '\u06F7');
//       x = x.replaceAll('\u0668', '\u06F8');
//       x = x.replaceAll('\u0669', '\u06F9');
//
//       return x;
//     }
//   }
//
//
//   /// Replaces ك with ک, and ي with ی.
//   String withPersianLetters() {
//     if (this.isEmpty) {
//       return this;
//     }
//
//     var x = this;
//     x = x.replaceAll('\u064A', '\u06CC');
//     x = x.replaceAll('\u0643', '\u06A9');
//
//     return x;
//   }
// }

extension JalaliStringExtensions on Jalali{
  String jalaliDateFormat(){
    final f = formatter;
    return '${f.yyyy}-${f.dd}-${f.mm}';
  }
  String jalaliTimeFormat(){
    return DateFormat('hh:mm').format(toDateTime());
  }
}
extension GregorianStringExtensions on Gregorian{
  String gregorianDateFormat(){
    final f = formatter;
    return '${f.yyyy}-${f.mm}-${f.dd}';
  }
  String gregorianTimeFormat(){
    return DateFormat('hh:mm').format(toDateTime());
  }
}
extension PersianStringExtensions on String {
  String convertNumberWithLanguage({bool? languageEn}){
    languageEn ??= LanguageState.language == Language.en;
    if(languageEn){
      if (isEmpty) {
        return this;
      }
      var x = this;
      x = x.replaceAll('\u06F0', '0');
      x = x.replaceAll('\u06F1', '1');
      x = x.replaceAll('\u06F2', '2');
      x = x.replaceAll('\u06F3', '3');
      x = x.replaceAll('\u06F4', '4');
      x = x.replaceAll('\u06F5', '5');
      x = x.replaceAll('\u06F6', '6');
      x = x.replaceAll('\u06F7', '7');
      x = x.replaceAll('\u06F8', '8');
      x = x.replaceAll('\u06F9', '9');

      x = x.replaceAll('\u0660', '0');
      x = x.replaceAll('\u0661', '1');
      x = x.replaceAll('\u0662', '2');
      x = x.replaceAll('\u0663', '3');
      x = x.replaceAll('\u0664', '4');
      x = x.replaceAll('\u0665', '5');
      x = x.replaceAll('\u0666', '6');
      x = x.replaceAll('\u0667', '7');
      x = x.replaceAll('\u0668', '8');
      x = x.replaceAll('\u0669', '9');

      return x;
    }else{
      if (this.isEmpty) {
        return this;
      }
      var x = this;

      x = x.replaceAll('0', '\u06F0');
      x = x.replaceAll('1', '\u06F1');
      x = x.replaceAll('2', '\u06F2');
      x = x.replaceAll('3', '\u06F3');
      x = x.replaceAll('4', '\u06F4');
      x = x.replaceAll('5', '\u06F5');
      x = x.replaceAll('6', '\u06F6');
      x = x.replaceAll('7', '\u06F7');
      x = x.replaceAll('8', '\u06F8');
      x = x.replaceAll('9', '\u06F9');

      x = x.replaceAll('\u0660', '\u06F0');
      x = x.replaceAll('\u0661', '\u06F1');
      x = x.replaceAll('\u0662', '\u06F2');
      x = x.replaceAll('\u0663', '\u06F3');
      x = x.replaceAll('\u0664', '\u06F4');
      x = x.replaceAll('\u0665', '\u06F5');
      x = x.replaceAll('\u0666', '\u06F6');
      x = x.replaceAll('\u0667', '\u06F7');
      x = x.replaceAll('\u0668', '\u06F8');
      x = x.replaceAll('\u0669', '\u06F9');

      return x;
    }
  }

  String changeSeqWithLanguage(){
    if(length > 1){
      String f = characters.first;
      StringBuffer stb = StringBuffer();
      for(int index = 1;index < characters.length;index++){
        stb.write(characters.elementAt(index));
      }
      stb.write(f);
      return stb.toString();
    }else{
      return this;
    }
  }

  String changeCharacterWithLanguage({bool? languageEn}){
    languageEn ??= LanguageState.language == Language.en;
    if (isEmpty) {
      return this;
    }
    if(languageEn){
      var map = {
        'ئ':'m',
        'ض':'q',
        'ص':'w',
        'ث':'e',
        'ق':'r',
        'ف':'t',
        'غ':'y',
        'ع':'u',
        'ه':'i',
        'خ':'o',
        'ح':'p',
        'ج':'[',
        'چ':']',
        'ش':'a',
        'س':'s',
        'ی':'d',
        'ب':'f',
        'ل':'g',
        'ا':'h',
        'ت':'j',
        'ن':'k',
        'م':'l',
        'ک':';',
        'گ':"'",
        'ظ':'z',
        'ط':'x',
        'ز':'c',
        'ر':'v',
        'ذ':'b',
        'د':'n',
        'پ':'m',
        'و':',',
        '؟':'?',
      };
      StringBuffer stb = StringBuffer();
      for(int index = 0;index < characters.length;index++){
        String? c = map[characters.elementAt(index)];
        if(c == null){
          stb.write(characters.elementAt(index));
        }else{
          stb.write(c);
        }
      }
      return stb.toString();
    }else{
      String value  = toLowerCase();
      var map = {
        'q': 'ض',
        'w': 'ص',
        'e': 'ث',
        'r': 'ق',
        't': 'ف',
        'y': 'غ',
        'u': 'ع',
        'i': 'ه',
        'o': 'خ',
        'p': 'ح',
        '[': 'ج',
        ']': 'چ',
        'a': 'ش',
        's': 'س',
        'd': 'ی',
        'f': 'ب',
        'g': 'ل',
        'h': 'ا',
        'j': 'ت',
        'k': 'ن',
        'l': 'م',
        ';': 'ک',
        "'": 'گ',
        'z': 'ظ',
        'x': 'ط',
        'c': 'ز',
        'v': 'ر',
        'b': 'ذ',
        'n': 'د',
        'm': 'ئ',
        '~': 'پ',
        ',': 'و',
        '?': '؟',};
      StringBuffer stb = StringBuffer();
      for(int index = 0;index < value.characters.length;index++){
        String? c = map[value.characters.elementAt(index)];
        if(c == null){
          stb.write(value.characters.elementAt(index));
        }else{
          stb.write(c);
        }
      }
      return stb.toString();
    }
  }

  /// Replaces ك with ک, and ي with ی.
  String withPersianLetters() {
    if (isEmpty) {
      return this;
    }

    var x = this;
    x = x.replaceAll('\u064A', '\u06CC');
    x = x.replaceAll('\u0643', '\u06A9');

    return x;
  }
}