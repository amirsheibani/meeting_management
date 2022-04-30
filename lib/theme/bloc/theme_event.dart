import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';

abstract class ThemeEvent{}

class InitialThemeEvent extends ThemeEvent{
  final PlatformType platformType;

  InitialThemeEvent(this.platformType);
}
class LoadThemeEvent extends ThemeEvent{
  LoadThemeEvent();
}
class SetThemeEvent extends ThemeEvent{
  final bool light;
  SetThemeEvent(this.light);
}

class SetAutoThemeEvent extends ThemeEvent{
  final bool isManual;
  SetAutoThemeEvent(this.isManual);
}