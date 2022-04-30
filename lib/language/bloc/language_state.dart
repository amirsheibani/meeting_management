import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'language_status.dart';

class LanguageState {
  final LanguageStatus languageStatus;
  final Locale locale;
  static Language language = Language.en;

  LanguageState({this.languageStatus = const LanguageInitial(),Locale? locale}) : locale = locale ?? const Locale('en');

  LanguageState copyWith({LanguageStatus? languageStatus,Locale? locale,Language? language}) {
    LanguageState.language = language ?? LanguageState.language;
    return LanguageState(languageStatus: languageStatus ?? this.languageStatus,locale: locale ?? this.locale);
  }
}
