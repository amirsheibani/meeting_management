import 'package:flutter/material.dart';
import 'package:meeting_management/theme/bloc/theme_status.dart';


class ThemeState {
  final ThemeStatus? themeStatus;
  ThemeData? themeData;
  bool? isManual;
  bool? isLight;

  ThemeState({this.themeStatus = const ThemeInitial(),ThemeData? themeData,this.isManual = false,this.isLight = true}) : themeData = themeData ?? ThemeData.light();

  ThemeState copyWith({ThemeStatus? themeStatus,ThemeData? themeData,bool? isManual,bool? isLight}) {
    return ThemeState(themeStatus: themeStatus ?? this.themeStatus,themeData: themeData ?? this.themeData,isManual: isManual ?? this.isManual,isLight: isLight ?? this.isLight);
  }
}
