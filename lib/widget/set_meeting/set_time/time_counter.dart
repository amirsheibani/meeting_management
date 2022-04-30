import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:shamsi_date/shamsi_date.dart';


class TimeCounter extends StatefulWidget {
  const TimeCounter({Key? key, required this.dateTime, required this.finalDateTime, this.textStyle}) : super(key: key);
  final DateTime dateTime;
  final Function(DateTime dateTime) finalDateTime;
  final TextStyle? textStyle;

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  int _hour = 0;
  int _min = 0;
  int _second = 0;
  Gregorian? _gregorianTime;
  Jalali? _jalaliTime;
  late DateTime _increasedDateTime;

  @override
  void initState() {
    _increasedDateTime = widget.dateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (LanguageState.language == Language.en) {
      _gregorianTime = _increasedDateTime.toGregorian();
      _hour = _gregorianTime!.hour < 10 ? _gregorianTime!.hour : _gregorianTime!.hour.convertHalfFormatHour();
      _min = _gregorianTime!.minute;
      _second = _gregorianTime!.second;
    } else {
      _jalaliTime = _increasedDateTime.toJalali();
      _hour = _jalaliTime!.hour < 10 ? _jalaliTime!.hour : _jalaliTime!.hour.convertHalfFormatHour();
      _min = _jalaliTime!.minute;
      _second = _jalaliTime!.second;
    }
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Row(
        children: [
          SizedBox(
            width: constraints.maxWidth * 0.22,
            height: 64,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppTheme.colorBox('meeting_color_nine'), width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(hours: 1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronUp,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(hours: -1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronDown,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        _hour < 10 ? '0$_hour'.convertNumberWithLanguage() : '$_hour'.convertNumberWithLanguage(),
                        style: widget.textStyle ?? const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (constraints.maxWidth * 0.05),
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.colorBox('meeting_color_four'),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: (constraints.maxWidth * 0.05),
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.colorBox('meeting_color_four'),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(
            width: constraints.maxWidth * 0.22,
            height: 64,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppTheme.colorBox('meeting_color_nine'), width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(minutes: 1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronUp,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(minutes: -1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronDown,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        _min < 10 ? '0$_min'.convertNumberWithLanguage() : '$_min'.convertNumberWithLanguage(),
                        style: widget.textStyle ?? const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: (constraints.maxWidth * 0.05),
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.colorBox('meeting_color_four'),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: (constraints.maxWidth * 0.05),
                height: 12,
                decoration: BoxDecoration(
                  color: AppTheme.colorBox('meeting_color_four'),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          SizedBox(
            width: constraints.maxWidth * 0.22,
            height: 64,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppTheme.colorBox('meeting_color_nine'), width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(seconds: 1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronUp,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => setState(() {
                              _increasedDateTime = _increasedDateTime.add(const Duration(seconds: -1));
                              widget.finalDateTime(_increasedDateTime);
                            }),
                            child: Icon(
                              FeatherIcons.chevronDown,
                              size: 24,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Center(
                      child: Text(
                        _second < 10 ? '0$_second'.convertNumberWithLanguage() : '$_second'.convertNumberWithLanguage(),
                        style: widget.textStyle ?? const TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: constraints.maxWidth * 0.03,
          ),
          SizedBox(
            width: constraints.maxWidth * 0.15,
            height: 64,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: AppTheme.colorBox('meeting_color_nine'), width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  LanguageState.language == Language.en
                      ? _gregorianTime!.hour >= 12
                          ? Languages.of(context).meetingTimePM.toUpperCase()
                          : Languages.of(context).meetingTimeAM.toUpperCase()
                      : _jalaliTime!.hour >= 12
                          ? Languages.of(context).meetingTimePM.toUpperCase()
                          : Languages.of(context).meetingTimeAM.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one')),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
