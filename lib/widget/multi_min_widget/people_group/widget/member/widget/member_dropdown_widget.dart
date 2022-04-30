import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';

import 'bloc/person_dropdown_bloc.dart';
import 'form_drop_down.dart';

class MemberDropdownWidget extends StatefulWidget {
  const MemberDropdownWidget({Key? key, required this.change, this.title, this.titleColor, this.textColor, required this.validations}) : super(key: key);
  final Function change;

  // final GlobalKey<ScaffoldState> scaffoldKey;
  final String? title;
  final Color? titleColor;
  final Color? textColor;
  final List<Function> validations;

  @override
  _MemberDropdownWidgetState createState() => _MemberDropdownWidgetState();
}

class _MemberDropdownWidgetState extends State<MemberDropdownWidget> {
  final Map<String, dynamic> _items = {};

  @override
  void initState() {
    context.read<PersonDropdownBloc>().add(const GetAllPersonEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonDropdownBloc, PersonDropdownState>(
      listener: (BuildContext context, PersonDropdownState state) {
        if (state is PersonDropdownErrorState) {
          debugPrint('all person list Ex:${state.props[0]}');
        }
      },
      child: BlocBuilder<PersonDropdownBloc, PersonDropdownState>(builder: (BuildContext context, PersonDropdownState state) {
        _items.clear();
        _items[Languages.of(context).dropdownMustSelectOneOption] = null;
        if (state is GetAllPersonState) {
          _items.clear();
          _items[Languages.of(context).dropdownMustSelectOneOption] = null;
          List<Member> _data = state.props[0]!;
          _data.sort((a, b) => b.type!.compareTo(a.type!));
          for (Member item in _data) {
            _items['${item.firstName} ${item.lastName}'] = item;
          }
        }
        return FormDropDown(
          dropdownMenuItemStyle: Theme.of(context).textTheme.headline6!.copyWith(
                color: AppTheme.colorBox('meeting_color_four'),
              ),
          textColor: AppTheme.colorBox('meeting_color_four'),
          firstItemSelectMessage: Languages.of(context).dropdownMustSelectOneOption,
          alignmentCenterLeft: LanguageState.language == Language.en,
          enabledBorderColor: AppTheme.colorBox('meetings_color_two'),
          readOnly: false,
          items: _items,
          validations: widget.validations,
          onChange: (value) {
            if (value is Person) {
              widget.change(value);
            }
          },
        );
      }),
    );
  }
}
