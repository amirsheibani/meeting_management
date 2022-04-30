import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/meetings/widget/custom_switch.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'bloc/invitees_bloc/invitees_bloc.dart';
import 'bloc/location_bloc/location_meeting_bloc.dart';

class MeetingsItem extends StatefulWidget {
  const MeetingsItem({Key? key, this.titleStyle, this.textStyle, this.backgroundColor, this.iconColor, this.canceledTextStyle, this.switchActiveColor, required this.meetingModel}) : super(key: key);

  final TextStyle? titleStyle;
  final TextStyle? textStyle;

  final Color? backgroundColor;
  final Color? iconColor;
  final Color? switchActiveColor;
  final TextStyle? canceledTextStyle;
  final MeetingModel meetingModel;

  @override
  _MeetingsItemState createState() => _MeetingsItemState();
}

class _MeetingsItemState extends State<MeetingsItem> {
  late DateTime nowTime;
  late DateTime _dateTime;
  bool disable = false;
  String _date = '';
  String _time = '';
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;
  Gregorian? _gregorianTime;
  Jalali? _jalaliTime;

  @override
  void initState() {
    _dateTime = DateTime.parse(widget.meetingModel.startDate!);
    nowTime = DateTime.now();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Languages.of(context);

    if (nowTime.isAfter(DateTime.parse(widget.meetingModel.startDate!))) {
      disable = true;
    } else {
      disable = false;
    }
    if (LanguageState.language == Language.en) {
      _gregorianDate = _dateTime.toGregorian();
      _date = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
    } else {
      _jalaliDate = _dateTime.toJalali();
      _date = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
    }
    if (LanguageState.language == Language.en) {
      _gregorianTime = _dateTime.toGregorian();
      _time =
      '${_gregorianTime!.hour < 10 ? '0${_gregorianTime!.hour.convertHalfFormatHour()}' : '${_gregorianTime!.hour.convertHalfFormatHour()}'}:${_gregorianTime!.minute < 10 ? '0${_gregorianTime!.minute}' : '${_gregorianTime!.minute}'}';
    } else {
      _jalaliTime = _dateTime.toJalali();
      _time = '${_jalaliTime!.hour < 10 ? '0${_jalaliTime!.hour.convertHalfFormatHour()}' : '${_jalaliTime!.hour.convertHalfFormatHour()}'}:${_jalaliTime!.minute < 10 ? '0${_jalaliTime!.minute}' : '${_jalaliTime!.minute}'}';
    }
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InviteesBloc(context.read<MeetingApiRepository>())..add(InviteesMeetingEvent(widget.meetingModel.id!))),
        BlocProvider(
          create: (context) => LocationMeetingBloc(context.read<LocationRepository>())..add(RetrieveLocationMeetingEvent(widget.meetingModel.locationId!)),
        ),
      ],
      child: AbsorbPointer(
        absorbing: disable ? true : false,
        child: Container(
          height: 130.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: disable
                ? widget.backgroundColor != null
                    ? widget.backgroundColor!.withOpacity(0.5)
                    : const Color(0xFF016683).withOpacity(0.5)
                : widget.backgroundColor != null
                    ? widget.backgroundColor!
                    : const Color(0xFF016683),
          ),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      widget.meetingModel.title ?? 'default value',
                      style: widget.titleStyle ?? const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Color(0xFFFFFFFF), decorationColor: Color(0xFFB00020), decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    if (widget.meetingModel.status == 4)
                      Expanded(
                        flex: 1,
                        child: Text(
                          Languages.of(context).meetingCanceled,
                          style: widget.canceledTextStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFB00020)),
                        ),
                      ),
                    const Spacer(),
                    if (!disable)
                      CustomSwitch(
                        activeColor: widget.switchActiveColor,
                        inactiveThumbColor: AppTheme.colorBox('meeting_color_seven'),
                        trackColor: AppTheme.colorBox('meeting_color_eight'),
                        canceled: widget.meetingModel.status == 4,
                        textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.w400, color: AppTheme.colorBox('meeting_color_eight')),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ListTile(
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: Text(
                          _date.convertNumberWithLanguage(),
                          style: widget.textStyle ??
                              const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFFFFFF),
                              ),
                        ),
                        leading: Icon(
                          FeatherIcons.calendar,
                          color: widget.iconColor ?? const Color(0xFFFFFFFF),
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                      height: 16,
                      child: MinClock(
                        dateTime: _dateTime,
                        strokeWidth: 1.2,
                        strokeWidthCircle: 2,
                        color: widget.iconColor ?? Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            _time.convertNumberWithLanguage(),
                            style: widget.textStyle ??
                                const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            LanguageState.language == Language.en
                                ? _gregorianTime!.hour >= 12 && _gregorianTime!.hour <= 24
                                    ? Languages.of(context).meetingTimePM
                                    : Languages.of(context).meetingTimeAM
                                : _jalaliTime!.hour >= 12 && _jalaliTime!.hour <= 24
                                    ? Languages.of(context).meetingTimePM
                                    : Languages.of(context).meetingTimeAM,
                            style: widget.textStyle ??
                                const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ListTile(
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        title: BlocConsumer<LocationMeetingBloc, LocationMeetingState>(
                          listener: (context, state) {
                            if (state is LocationMeetingError) {
                              debugPrint('location meeting Ex:${state.props[0]}');
                            }
                          },
                          builder: (context, state) {
                            if (state is LocationMeetingRetrieve) {
                              String t = '';
                              if(state.props.isNotEmpty){
                                List<LocationModel> result = state.props[0];
                                t = result.last.name!;
                              }
                              return Text(t,style: widget.textStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFFFFFFF)));
                            }
                            return const SizedBox();
                          },
                        ),
                        leading: Icon(
                          FeatherIcons.mapPin,
                          color: widget.iconColor ?? const Color(0xFFFFFFFF),
                          size: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: BlocConsumer<InviteesBloc, InviteesState>(
                        listener: (context, state) {
                          if (state is InviteesError) {
                            debugPrint('invitees Ex:${state.props[0]}');
                          }
                        },
                        builder: (context, state) {
                          if(state is InviteesRetrieve){
                            List<InviteesModel> members = state.props[0];
                            return ListTile(
                              minVerticalPadding: 0,
                              horizontalTitleGap: 0,
                              title: Row(
                                children: [
                                  Text(
                                    '${members.length}'.convertNumberWithLanguage(),
                                    style: widget.textStyle ??
                                        const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    Languages.of(context).meetingMember,
                                    style: widget.textStyle ??
                                        const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFFFFFFF),
                                        ),
                                  ),
                                ],
                              ),
                              leading: Icon(
                                members.isEmpty ? FeatherIcons.user : FeatherIcons.users,
                                color: widget.iconColor ?? const Color(0xFFFFFFFF),
                                size: 20,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
