import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';
import 'bloc/invite_people_dropdown_bloc.dart';
import 'form_drop_down.dart';

class InvitePeopleDropdownWidget extends StatefulWidget {
  const InvitePeopleDropdownWidget({Key? key, required this.change, required this.scaffoldKey, this.textColor, required this.validations, this.defaultValue}) : super(key: key);
  final Function change;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color? textColor;
  final List<Function> validations;
  final dynamic defaultValue;

  @override
  _InvitePeopleDropdownWidgetState createState() => _InvitePeopleDropdownWidgetState();
}

class _InvitePeopleDropdownWidgetState extends State<InvitePeopleDropdownWidget> {
  final Map<String, dynamic> _items = {};
  String? _defaultValue;

  @override
  void initState() {
    context.read<InvitePeopleDropdownBloc>().add(const RetrievePeoplesDropdownEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<InvitePeopleDropdownBloc, InvitePeopleDropdownState>(
      listener: (context, InvitePeopleDropdownState state) {
        if (state is InvitePeopleDropdownErrorState) {
          debugPrint('all persons & groups list Ex:${state.props[0]}');
        }
      },
      builder: (context, InvitePeopleDropdownState state) {
        _items.clear();
        _items[Languages.of(context).dropdownMustSelectOneOption] = null;
        if (state is RetrieveInvitePeopleDropdownLoadedState) {
          _items.clear();
          _items[Languages.of(context).dropdownMustSelectOneOption] = null;
          List<Object> _data = state.props[0];
          List<Member> _members =[];
          List<PeopleGroupModel> _groups =[];

          for(var item in _data){
            if(item is Member){
              _members.add(item);
            }else if(item is PeopleGroupModel){
              _groups.add(item);
            }
          }

          _members.sort((a, b) => b.firstName!.compareTo(a.lastName!));
          _groups.sort((a, b) => b.name!.compareTo(a.name!));

          for (Member item in _members) {
            _items['${item.firstName} ${item.lastName}'] = item;
          }
          for (PeopleGroupModel item in _groups) {
            _items['${item.name}'] = item;
          }
        }
        return FormDropDown(
          height: 100,
          dropdownMenuItemStyle: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meeting_color_nine'), fontWeight: FontWeight.w400),
          // defaultValue: _defaultValue,
          firstItemSelectMessage: Languages.of(context).meetingSelectLocation,
          alignmentCenterLeft: LanguageState.language == Language.en,
          enabledBorderColor: AppTheme.colorBox('meeting_color_nine'),
          readOnly: false,
          items: _items,
          validations: widget.validations,
          onChange: (value) {
            widget.change(value);
          },
        );
      },
    );
  }

// _showExceptionMessage(Exception exception) {
//   ScaffoldMessenger.of(widget.scaffoldKey.currentContext!).showSnackBar(
//     SnackBar(
//       backgroundColor: AppTheme.colorBox('snack_bar_error_background_color'),
//       content: ErrorSnackBar(
//         height: 200,
//         title: exception.runtimeType.toString(),
//         message: exception.toString(),
//         ok: () {
//           ScaffoldMessenger.of(widget.scaffoldKey.currentContext!).hideCurrentSnackBar();
//         },
//         cancel: () {},
//         // color: AppTheme.colorBox('snack_bar_error_color'),
//       ),
//       duration: const Duration(minutes: 3),
//     ),
//   );
// }
}
