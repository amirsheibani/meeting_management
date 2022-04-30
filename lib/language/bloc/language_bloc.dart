
import 'package:behpardaz_flutter_custom_utility/tools/utility/local_storage.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/constant.dart';


import 'language_event.dart';
import 'language_state.dart';
import 'language_status.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageState()) {
    on<LoadLanguageEvent>((event, emit) async {
      var l = await LocalStorage.instance.readString(languageCode);
      var c = await LocalStorage.instance.readString(countryCode);
      String _languageCode;
      String _countryCode;
      Language _language;
      switch(l[languageCode]){
        case languageCodeEn:{
          _languageCode = 'en';
          _language = Language.en;
        }break;
        case languageCodeFa:{
          _languageCode = 'fa';
          _language = Language.fa;
        }break;
        default:{
          _languageCode = 'en';
          _language = Language.en;
        }
      }
      switch(c[countryCode]){
        case countryCodeUS:{
          _countryCode = 'US';
        }break;
        case countryCodeIR:{
          _countryCode = 'IR';
        }break;
        default:{
          _countryCode = 'US';
        }
      }
      emit(state.copyWith(languageStatus: const LanguageLoaded(),locale: Locale(_languageCode,_countryCode),language: _language));
    });
    on<ChangeLanguageEvent>((event, emit) async {
      String _languageCode;
      String _countryCode;
      switch(event.language){
        case Language.en:{
          await LocalStorage.instance.saveString({languageCode:languageCodeEn});
          await LocalStorage.instance.saveString({countryCode:countryCodeUS});
          _languageCode = 'en';
          _countryCode = 'US';
        }break;
        case Language.fa:{
          await LocalStorage.instance.saveString({languageCode:languageCodeFa});
          await LocalStorage.instance.saveString({countryCode:countryCodeIR});
          _languageCode = 'fa';
          _countryCode = 'IR';
        }break;
      }

      emit(state.copyWith(languageStatus: const LanguageLoaded(),locale: Locale(_languageCode,_countryCode),language:event.language));
    });
  }
}
