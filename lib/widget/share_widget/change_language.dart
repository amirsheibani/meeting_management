import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/bloc/language_bloc.dart';
import 'package:meeting_management/language/bloc/language_event.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:provider/src/provider.dart';

class ChangeLanguage extends StatefulWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  _ChangeLanguageState createState() => _ChangeLanguageState();
}

class _ChangeLanguageState extends State<ChangeLanguage> {
  List<String> _languagesList = [];

  @override
  Widget build(BuildContext context) {
    _languagesList = [Languages.of(context).english, Languages.of(context).persian];

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Material(
          child: DropdownButtonHideUnderline(
            child: SizedBox(
              width: 32,
              child: Center(
                child: DropdownButton(
                    isExpanded: true,
                    isDense: false,
                    elevation: 0,
                    dropdownColor: AppTheme.colorBox('meetings_color_three'),
                    icon: Icon(FeatherIcons.chevronDown, size: 25, color: AppTheme.colorBox('meetings_color_three')),
                    // value: _currentSelectedValue,
                    items: _languagesList.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Center(
                          child: Text(
                            item,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue == Languages.of(context).persian) {
                        context.read<LanguageBloc>().add((ChangeLanguageEvent(Language.fa)));
                        // _currentSelectedValue = newValue;
                      } else {
                        context.read<LanguageBloc>().add((ChangeLanguageEvent(Language.en)));
                        // _currentSelectedValue = newValue;
                      }
                    }),
              ),
            ),
          ),
        ),
        CircleAvatar(
          radius: 15.0,
          backgroundImage:
              LanguageState.language == Language.en ? Image.asset('icons/flags/png/gb.png', package: 'country_icons').image : Image.asset('icons/flags/png/ir.png', package: 'country_icons').image,
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
