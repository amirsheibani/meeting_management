
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/share_widget/form_drop_down.dart';


class GenderDropdownWidget extends StatefulWidget {
  const GenderDropdownWidget({Key? key, required this.change, this.title, this.titleColor, this.textColor, required this.validations, this.defaultValue}) : super(key: key);
  final Function change;
  final String? title;
  final Color? titleColor;
  final Color? textColor;
  final List<Function> validations;
  final dynamic defaultValue;

  @override
  _GenderDropdownWidgetState createState() => _GenderDropdownWidgetState();
}

class _GenderDropdownWidgetState extends State<GenderDropdownWidget> {
  Map<String, dynamic> _items = {};
  String? _defaultValue;

  @override
  void initState() {
    // context.read<GenderItemBloc>().add(GetGenderItemEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _items = {Languages.of(context).meetingSelectGender: null, Languages.of(context).male: 1, Languages.of(context).female: 0};

    // if (widget.defaultValue is bool) {
    //   _defaultValue = widget.defaultValue ? Languages.of(context).male : Languages.of(context).female;
    // }

    // return BlocListener<GenderItemBloc, GenderItemState>(
      // listener: (BuildContext context, GenderItemState state) {
      //   if (state.genderItemStatus is GenderItemFailed) {
      //     _showExceptionMessage((state.genderItemStatus as GenderItemFailed).exception);
      //   }
      // },
      // child: BlocBuilder<GenderItemBloc, GenderItemState>(
      //   builder: (BuildContext context, GenderItemState state) {
      //     if(!(state.genderItemStatus is GenderItemInitial)){
      //       _items.clear();
      //       _items[Languages.of(context).dropdownMustSelectOneOption] = null;
      //       if (state.genderItemStatus is GenderItemSuccess) {
      //         _items.clear();
      //         _items[Languages.of(context).dropdownMustSelectOneOption] = null;
      //         List<DropdownItemModel> _data = state.dropdownItems;
      //         for (DropdownItemModel item in _data) {
      //           if (LanguageState.language == Language.en) {
      //             _items[item.titleEnglish ?? ''] = item.id;
      //           } else {
      //             _items[item.titlePersian ?? ''] = item.id;
      //           }
      //         }
      //
      //       }
            return FormDropDown(
              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
              // height: 100,
              primaryBackgroundColor: Colors.transparent,
              iconColor: AppTheme.colorBox('meeting_color_four'),
              dropdownMenuItemStyle :Theme.of(context).textTheme.headline6!.copyWith(color:AppTheme.colorBox('meeting_color_four'),fontWeight: FontWeight.w400 ),
              // defaultValue: _defaultValue,
              firstItemSelectMessage: Languages.of(context).meetingSelectGender,
              alignmentCenterLeft: LanguageState.language == Language.en,
              enabledBorderColor:AppTheme.colorBox('meeting_color_four'),
              readOnly: false,
              items: _items,
              validations: widget.validations,
              onChange: (value){
                widget.change(value);
              },
            );
          // }
          // else{
          //   return SizedBox();
          // }

    //     },
    //   ),
    // );
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
