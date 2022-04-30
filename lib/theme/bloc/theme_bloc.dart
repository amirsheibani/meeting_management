
import 'package:behpardaz_flutter_custom_utility/tools/utility/local_storage.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';


import 'theme_event.dart';
import 'theme_state.dart';
import 'theme_status.dart';


class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<LoadThemeEvent>((event, emit) async {
      PlatformType platformType;
      if (PlatformInfo().isWeb()) {
        platformType = PlatformType.Web;
      }else if(PlatformInfo().isAppOS()){
        platformType = PlatformType.iOS;
      }else{
        platformType = PlatformType.MacOS;
      }
      var v = await LocalStorage.instance.readString(themeAutoChange);
      bool _themeAutoChange =  v[themeAutoChange] == '' || v[themeAutoChange] == themeAutoChangeTrue;
      if(_themeAutoChange){
        var window = WidgetsBinding.instance!.window;
        var brightness = window.platformBrightness;
        bool isDarkMode =  brightness == Brightness.dark;
        if(isDarkMode){
          emit(state.copyWith(themeStatus: const DarkThemeLoaded(),themeData: AppTheme.darkTheme(platformType,LanguageState.language),isManual: false,isLight:false));
        }else{
          emit(state.copyWith(themeStatus: const LightThemeLoaded(),themeData: AppTheme.lightTheme(platformType,LanguageState.language),isManual: false,isLight:true));
        }
      }else{
        var tm = await LocalStorage.instance.readString(themeMode);
        bool _themeMode = tm[themeMode] != '' && tm[themeMode] == themeModeLight;
        if(_themeMode){
          emit(state.copyWith(themeStatus: const LightThemeLoaded(),themeData: AppTheme.lightTheme(platformType,LanguageState.language),isManual: true,isLight:true));
        }else{
          emit(state.copyWith(themeStatus: const DarkThemeLoaded(),themeData: AppTheme.darkTheme(platformType,LanguageState.language),isManual: true,isLight:false));
        }
      }
    });
    on<SetThemeEvent>((event, emit) async {
      PlatformType platformType;
      if (PlatformInfo().isWeb()) {
        platformType = PlatformType.Web;
      }else if(PlatformInfo().isAppOS()){
        platformType = PlatformType.iOS;
      }else{
        platformType = PlatformType.MacOS;
      }
      if(event.light){
        await LocalStorage.instance.saveString({themeMode:themeModeLight});
        emit(state.copyWith(themeStatus: const LightThemeLoaded(),themeData: AppTheme.lightTheme(platformType,LanguageState.language),isManual: true,isLight:true));
      }else{
        await LocalStorage.instance.saveString({themeMode:themeModeDark});
        emit(state.copyWith(themeStatus: const DarkThemeLoaded(),themeData: AppTheme.darkTheme(platformType,LanguageState.language),isManual: true,isLight:false));
      }
    });

    on<SetAutoThemeEvent>((event, emit) async {
      PlatformType platformType;
      if (PlatformInfo().isWeb()) {
        platformType = PlatformType.Web;
      }else if(PlatformInfo().isAppOS()){
        platformType = PlatformType.iOS;
      }else{
        platformType = PlatformType.MacOS;
      }
      if(event.isManual){
        await LocalStorage.instance.saveString({themeAutoChange:themeAutoChangeFalse});
        var tm = await LocalStorage.instance.readString(themeMode);
        bool _themeMode = tm[themeMode] != '' && tm[themeMode] == themeModeLight;
        if(_themeMode){
          emit(state.copyWith(themeStatus: const LightThemeLoaded(),themeData: AppTheme.lightTheme(platformType,LanguageState.language),isManual: true,isLight:true));
        }else{
          emit(state.copyWith(themeStatus: const DarkThemeLoaded(),themeData: AppTheme.darkTheme(platformType,LanguageState.language),isManual: true,isLight:false));
        }
      }else{
        await LocalStorage.instance.saveString({themeAutoChange:themeAutoChangeTrue});
        var window = WidgetsBinding.instance!.window;
        var brightness = window.platformBrightness;
        bool isDarkMode =  brightness == Brightness.dark;
        if(isDarkMode){
          emit(state.copyWith(themeStatus: const DarkThemeLoaded(),themeData: AppTheme.darkTheme(platformType,LanguageState.language),isManual: false,isLight:false));
        }else{
          emit(state.copyWith(themeStatus: const LightThemeLoaded(),themeData: AppTheme.lightTheme(platformType,LanguageState.language),isManual: false,isLight:true));
        }
      }
    });
  }
}
