import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/location_drop_down/widget/location_drop_down_widget.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/set_asset_widget.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'asset_drop_down/widget/asset_drop_down_widget.dart';

class SetLocationAndAsset extends StatefulWidget {
  const SetLocationAndAsset({Key? key, required this.dateTime, required this.scaffoldKey, required this.changeLocation, required this.changeAsset}) : super(key: key);
  final DateTime dateTime;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(LocationModel value) changeLocation;
  final Function(List<AssetModel> value) changeAsset;

  @override
  _SetLocationAndAssetState createState() => _SetLocationAndAssetState();
}

class _SetLocationAndAssetState extends State<SetLocationAndAsset> {
  String _date = '';
  String _time = '';
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;
  Gregorian? _gregorianTime;
  Jalali? _jalaliTime;
  @override
  Widget build(BuildContext context) {
    if (LanguageState.language == Language.en) {
      _gregorianDate = widget.dateTime.toGregorian();
      _date = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
    } else {
      _jalaliDate = widget.dateTime.toJalali();
      _date = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
    }
    if (LanguageState.language == Language.en) {
      _gregorianTime = widget.dateTime.toGregorian();
      _time =
      '${_gregorianTime!.hour < 10 ? '0${_gregorianTime!.hour.convertHalfFormatHour()}' : '${_gregorianTime!.hour.convertHalfFormatHour()}'}:${_gregorianTime!.minute < 10 ? '0${_gregorianTime!.minute}' : '${_gregorianTime!.minute}'}';
    } else {
      _jalaliTime = widget.dateTime.toJalali();
      _time = '${_jalaliTime!.hour < 10 ? '0${_jalaliTime!.hour.convertHalfFormatHour()}' : '${_jalaliTime!.hour.convertHalfFormatHour()}'}:${_jalaliTime!.minute < 10 ? '0${_jalaliTime!.minute}' : '${_jalaliTime!.minute}'}';
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.only(right: constraints.maxWidth * 0.05, left: constraints.maxWidth * 0.05),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.calendar,
                    size: 24,
                    color: AppTheme.colorBox('meeting_color_four'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.01,
                  ),
                  Center(
                    child: Text(
                      _date.convertNumberWithLanguage(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.03,
                  ),
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: MinClock(
                      dateTime: widget.dateTime,
                      strokeWidth: 1.2,
                      strokeWidthCircle: 2,
                      color:AppTheme.colorBox('meeting_color_four'),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.01,
                  ),
                  Center(
                    child: Text(
                      _time.convertNumberWithLanguage(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.mapPin,
                    size: 24,
                    color: AppTheme.colorBox('meeting_color_four'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.01,
                  ),
                  Center(
                    child: Text(
                      Languages.of(context).meetingLocation,
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              LocationDropdownWidget(scaffoldKey: widget.scaffoldKey, validations: [], change: widget.changeLocation,),
              const SizedBox(height: 16,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    FeatherIcons.server,
                    size: 24,
                    color: AppTheme.colorBox('meeting_color_four'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.01,
                  ),
                  Center(
                    child: Text(
                      Languages.of(context).meetingAssets,
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16,),
              Expanded(child: SetAssetWidget(scaffoldKey: widget.scaffoldKey,change: (value){
                widget.changeAsset(value);
              },))
            ],
          ),
        );
      }
    );
  }
}
