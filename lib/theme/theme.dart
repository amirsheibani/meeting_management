import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/enumerations.dart';

class AppTheme {
  static var fontName = "IranSans";
  static ThemeType _themeType = ThemeType.Dark;

  static var fontColorLightTheme = const Color(0xFF000000);
  static var fontColorDarkTheme = Colors.white;
  static final Map<String, dynamic> _lightColorBox = {
    //Metting
    'meetings_color_one': const Color(0xFF000000),
    'meetings_color_two': const Color(0x80016683),
    'meetings_color_three': const Color(0xFF016683),
    'meeting_color_four':const Color(0xFF030F34),
    'meeting_color_five':const Color(0x66FFFFFF),
    'meeting_color_six':Colors.transparent,
    'meeting_color_seven':const Color(0xFF00BBD0),
    'meeting_color_eight':const Color(0xFFFFFFFF),
    'meeting_color_nine':const Color(0xFF969C89),
    'meeting_color_ten':const Color(0xFFB00020),
    'meeting_color_eleven':const Color(0xFFF0F1F3),
    'meeting_color_twelve':const Color(0xFF03FF86),
    'meeting_color_thirteen':const Color(0xFFC4C4C4),
    'meeting_color_fourteen':const Color(0x66FFFFFF),
    'meeting_color_fifteen':const Color(0x0DFFFFFF),
    'meeting_color_sixteen': const Color(0xFF030027),
    'meeting_color_seventeen': const Color(0xFFF10505),
    'meeting_color_eighteen': const Color(0xFFBDCBCF),
    'meeting_color_nineteen': const Color(0xFF030F34),
  };
  static final Map<String, dynamic> _darkColorBox = {
    //Meeting
    'meetings_color_one': const Color(0xFF000000),
    'meetings_color_two': const Color(0x80016683),
    'meetings_color_three': const Color(0xFF016683),
    'meeting_color_four':const Color(0xFF030F34),
    'meeting_color_five':const Color(0x66FFFFFF),
    'meeting_color_six':Colors.transparent,
    'meeting_color_seven':const Color(0xFF00BBD0),
    'meeting_color_eight':const Color(0xFFFFFFFF),
    'meeting_color_nine':const Color(0xFF969C89),
    'meeting_color_ten':const Color(0xFFB00020),
    'meeting_color_eleven':const Color(0xFFF0F1F3),
    'meeting_color_twelve':const Color(0xFF03FF86),
    'meeting_color_thirteen':const Color(0xFFC4C4C4),
    'meeting_color_fourteen': Colors.grey.shade900,
    'meeting_color_fifteen':const Color(0x0DFFFFFF),
    'meeting_color_sixteen': const Color(0xFF030027),
    'meeting_color_seventeen': const Color(0xFFF10505),
    'meeting_color_eighteen': const Color(0xFFBDCBCF),
    'meeting_color_nineteen': const Color(0xFF030F34),
  };

  static TextTheme _buildTextTheme(TextTheme textTheme, Language language, PlatformType platformType) {
    if (platformType == PlatformType.Web) {
      if (language == Language.en) {
        return textTheme.copyWith(
          //Persian
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 41,),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 32,),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 23,),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 20,),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 18,),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 15,),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 14,),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 12,),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 11,),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 10,),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 13,),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 9,),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8,),
        );
      } else {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 39, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 30, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 21, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 18, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 15, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 13, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 12, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 11, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 10, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 9, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 11, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 8, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8, ),
        );
      }
    } else if (platformType == PlatformType.Android) {
      if (language == Language.en) {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 41, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 32, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 23, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 18, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 17, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 16, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 14, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 11, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 10, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 14, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 10, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8, ),
        );
      } else {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 41, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 32, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 23, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 18, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 17, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 16, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 14, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 11, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 10, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 14, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 10, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8, ),
        );
      }
    } else if (platformType == PlatformType.iOS) {
      if (language == Language.en) {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 30, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 27, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 25, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 22, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 17, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 16, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 14, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 13, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 12, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 12, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 10, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8, ),
        );
      } else {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 28, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 25, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 23, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 18, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 15, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 14, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 12, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 11, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 10, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 10, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 8, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 6, ),
        );
      }
    } else {
      if (language == Language.en) {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 30, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 27, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 25, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 22, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 17, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 16, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 14, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 13, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 12, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 12, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 10, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 8, ),
        );
      } else {
        return textTheme.copyWith(
          headline1: textTheme.headline1!.copyWith(fontFamily: fontName, fontSize: 28, ),
          headline2: textTheme.headline2!.copyWith(fontFamily: fontName, fontSize: 25, ),
          headline3: textTheme.headline3!.copyWith(fontFamily: fontName, fontSize: 23, ),
          headline4: textTheme.headline4!.copyWith(fontFamily: fontName, fontSize: 20, ),
          headline5: textTheme.headline5!.copyWith(fontFamily: fontName, fontSize: 18, ),
          headline6: textTheme.headline6!.copyWith(fontFamily: fontName, fontSize: 15, ),
          subtitle1: textTheme.subtitle1!.copyWith(fontFamily: fontName, fontSize: 14, ),
          subtitle2: textTheme.subtitle2!.copyWith(fontFamily: fontName, fontSize: 12, ),
          bodyText1: textTheme.bodyText1!.copyWith(fontFamily: fontName, fontSize: 11, ),
          bodyText2: textTheme.bodyText2!.copyWith(fontFamily: fontName, fontSize: 10, ),
          button: textTheme.button!.copyWith(fontFamily: fontName, fontSize: 10, ),
          caption: textTheme.caption!.copyWith(fontFamily: fontName, fontSize: 8, ),
          overline: textTheme.overline!.copyWith(fontFamily: fontName, fontSize: 6, ),
        );
      }
    }
  }

  static ThemeData lightTheme(PlatformType platformType, Language language) {
    _themeType = ThemeType.Light;
    final ThemeData base = ThemeData.light();
    TextTheme _textTheme = _buildTextTheme(base.textTheme, language, platformType);
    return base.copyWith(
      canvasColor: Colors.transparent,
      disabledColor: colorBox('menu_side_select'),
      iconTheme: base.iconTheme.copyWith(color: Colors.white),
      scaffoldBackgroundColor: const Color(0xFFEEEEEE),
      brightness: Brightness.dark,
      //icon deselect
      errorColor: Colors.redAccent,
      primaryColorLight:  const Color(0xFF22ABEE),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(backgroundColor: Colors.white10, selectedItemColor: const Color(0xFFFF0000), unselectedItemColor: const Color(0xBE9C6363)),
      primaryColorDark: Colors.white,
      primaryColor: Colors.white,
      backgroundColor: const Color(0xFF109BE3),
      accentColor: Colors.white,
      accentIconTheme: IconThemeData(color: Colors.white),
      dividerColor: Colors.lightBlueAccent,
      bottomAppBarColor: Colors.blueGrey.shade200,
      highlightColor: Colors.green,
      textTheme: _textTheme,
      scrollbarTheme: ScrollbarThemeData(
        crossAxisMargin: 1,
        interactive: true,
        thumbColor: MaterialStateProperty.all<Color>(const Color(0xFF242023)),
      ),
    );
  }

  static ThemeData darkTheme(PlatformType platformType, Language language) {
    _themeType = ThemeType.Dark;
    final ThemeData base = ThemeData.dark();
    TextTheme _textTheme = _buildTextTheme(base.textTheme, language, platformType);
    return base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF303C3F),
      backgroundColor: const Color(0xFF109BE3),
      canvasColor: Colors.transparent,
      disabledColor: colorBox('menu_side_select'),
      iconTheme: base.iconTheme.copyWith(color: Colors.white),

      brightness: Brightness.dark,
      //icon deselect
      errorColor: Colors.redAccent,
      primaryColorLight: const Color(0xFF22ABEE),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(backgroundColor: const Color(0xFF8C979C), selectedItemColor: const Color(0xFF91594A), unselectedItemColor: const Color(0xFF555354)),
      primaryColorDark: Colors.white,
      primaryColor: Colors.white,

      dividerColor: Colors.lightBlueAccent,
      bottomAppBarColor: Colors.blueGrey.shade200,
      highlightColor: Colors.green,
      textTheme: _textTheme,
      scrollbarTheme: ScrollbarThemeData(
        crossAxisMargin: 1,
        interactive: true,
        thumbColor: MaterialStateProperty.all<Color>(const Color(0xFF242023)),
      ),
    );
  }

  static dynamic colorBox(String colorName) {
    if (_themeType == ThemeType.Dark) {
      return _darkColorBox[colorName];
    } else {
      return _lightColorBox[colorName];
    }
  }
}
