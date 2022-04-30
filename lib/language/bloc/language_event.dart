

import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';

abstract class LanguageEvent{}

class LoadLanguageEvent extends LanguageEvent{
  LoadLanguageEvent();
}

class ChangeLanguageEvent extends LanguageEvent{
  final Language language;
  ChangeLanguageEvent(this.language);
}
