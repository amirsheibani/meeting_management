import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/asset_drop_down/bloc/set_asset_bloc.dart';

import 'form_drop_down.dart';

class AssetDropdownWidget extends StatefulWidget {
  const AssetDropdownWidget({Key? key, required this.change, required this.scaffoldKey, this.textColor, required this.validations, this.defaultValue}) : super(key: key);
  final Function(AssetModel value) change;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Color? textColor;
  final List<Function> validations;
  final dynamic defaultValue;

  @override
  _LocationDropdownWidgetState createState() => _LocationDropdownWidgetState();
}

class _LocationDropdownWidgetState extends State<AssetDropdownWidget> {
  final Map<String, dynamic> _items = {};
  String? _defaultValue;

  @override
  void initState() {
    context.read<SetAssetBloc>().add(const RetrieveAssetDropdownEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SetAssetBloc, SetAssetState>(
      listener: (context, SetAssetState state) {
        if (state is AssetDropdownErrorState) {
          debugPrint('all asset list Ex:${state.props[0]}');
        }
      },
      builder: (context, SetAssetState state) {
        _items.clear();
        _items[Languages.of(context).dropdownMustSelectOneOption] = null;
        if (state is RetrieveAssetDropdownLoadedState) {
          _items.clear();
          _items[Languages.of(context).dropdownMustSelectOneOption] = null;
          List<AssetModel> _data = state.props[0];
          _data.sort((a, b) => b.name!.compareTo(a.name!));
          for (AssetModel item in _data) {
            _items['${item.name}'] = item;
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
          // height: 100,
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