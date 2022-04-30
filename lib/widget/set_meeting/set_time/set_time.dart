import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/set_meeting/set_time/time_counter.dart';
import 'package:shamsi_date/shamsi_date.dart';


class SetTime extends StatefulWidget {
  const SetTime({
    Key? key,
    required this.dateTime, required this.updateDateTime,
  }) : super(key: key);
  final DateTime dateTime;
  final Function updateDateTime;

  @override
  _SetTimeState createState() => _SetTimeState();
}

class _SetTimeState extends State<SetTime> {
  String _data = '';
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;
  DateTime? _currentDateTime;
  @override
  void initState() {
    _currentDateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (LanguageState.language == Language.en) {
      _gregorianDate = _currentDateTime!.toGregorian();
      _data = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
    } else {
      _jalaliDate = _currentDateTime!.toJalali();
      _data = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
    }
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: EdgeInsets.only(right: constraints.maxWidth * 0.05, left: constraints.maxWidth * 0.05),
          child:Column(
            children: [
              Row(
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
                      _data.convertNumberWithLanguage(),
                      style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                  ),
                  // const Spacer(),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: constraints.maxWidth * 0.06, left: constraints.maxWidth * 0.06),
                  child: TimeCounter(
                    dateTime: _currentDateTime!,
                    finalDateTime: (DateTime value) {
                      setState(() {
                        _currentDateTime = value;
                        widget.updateDateTime(_currentDateTime);
                      });
                    },
                    textStyle: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one')),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
