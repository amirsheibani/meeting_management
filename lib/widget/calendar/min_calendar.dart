import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/invitation_meeting/bloc/pending_bloc/meeting_pending_bloc.dart';
import 'package:meeting_management/widget/meetings/bloc/meeting_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/meeting_mini_hourly/bloc/meeting_hourly_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/metting_mini_daily/bloc/meeting_daily_bloc.dart';
import 'package:persian/persian.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'bloc/calendar_bloc.dart';
import 'calendar_screen.dart';

class MinCalendar extends StatefulWidget {
  const MinCalendar({
    Key? key,
    this.background,
    this.borderColor,
    this.primaryColorController,
    this.yearStyle,
    this.currentDayColors,
    this.dayStyle,
    this.dayWeekNameStyle,
    required this.change,
    this.currentDayStyle,
    this.decoration,
    this.showSwitchToMaximum = true,
    this.defaultDateTime, required this.scaffoldKey, required this.person,
  }) : super(key: key);
  final Color? background;
  final Color? borderColor;
  final Color? primaryColorController;
  final TextStyle? yearStyle;
  final List<Color>? currentDayColors;
  final TextStyle? currentDayStyle;
  final TextStyle? dayStyle;
  final TextStyle? dayWeekNameStyle;
  final Function change;
  final BoxDecoration? decoration;
  final bool? showSwitchToMaximum;
  final DateTime? defaultDateTime;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Person person;

  @override
  _MinCalendarState createState() => _MinCalendarState();
}

class _MinCalendarState extends State<MinCalendar> {
  List<List<String>> _calenderMonth = [];
  Gregorian? _gregorianDate;
  Gregorian? _gregorianCurrentDay;

  Jalali? _jalaliDate;
  Jalali? _jalaliCurrentDay;

  DateTime? _selectedDay;

  @override
  void initState() {
    initDate();
    super.initState();
  }

  void initDate() async {
    DateTime _datetime = DateTime.now();
    if (widget.defaultDateTime != null && _selectedDay == null) {
      _selectedDay = widget.defaultDateTime!;
    } else {
      _selectedDay = _datetime;
    }
    _gregorianDate = _datetime.toGregorian();
    _gregorianCurrentDay = _datetime.toGregorian();
    _jalaliDate = _datetime.toJalali();
    _jalaliCurrentDay = _datetime.toJalali();

    if (LanguageState.language == Language.en) {
      calculateEnCalender();
    } else {
      calculateFaCalender();
    }
  }

  int getGregorianFirstDayOfWeekInMonth(Gregorian d) => Gregorian(d.year, d.month, 1).weekDay;

  Gregorian getGregorianLastDayOfMoth(Gregorian d) => d.withDay(d.monthLength);

  Gregorian getGregorianFirstDayOfMonth(Gregorian d) => Gregorian(d.year, d.month, 1);

  Gregorian nextMonthGregorian(Gregorian d) => d.addMonths(1);

  Gregorian previousMonthGregorian(Gregorian d) => d.addMonths(-1);

  int getJalaliFirstDayOfWeekInMonth(Jalali d) => Jalali(d.year, d.month, 1).weekDay;

  Jalali getJalaliLastDayOfMoth(Jalali d) => d.withDay(d.monthLength);

  Jalali getJalaliFirstDayOfMonth(Jalali d) => Jalali(d.year, d.month, 1);

  Jalali nextMonthJalali(Jalali d) => d.addMonths(1);

  Jalali previousMonthJalali(Jalali d) => d.addMonths(-1);

  void calculateEnCalender() {
    _calenderMonth = [];
    List<String> _calenderWeek = [];
    for (int i = 1; i < getGregorianFirstDayOfMonth(_gregorianDate!).weekDay; i++) {
      _calenderWeek.add(' ');
    }
    for (int i = 1; i <= getGregorianLastDayOfMoth(_gregorianDate!).day; i++) {
      if (_calenderWeek.length < 7) {
        _calenderWeek.add('$i');
      } else {
        _calenderMonth.add(_calenderWeek);
        _calenderWeek = [];
        _calenderWeek.add('$i');
      }
    }
    for (int i = getGregorianLastDayOfMoth(_gregorianDate!).weekDay; i < 7; i++) {
      _calenderWeek.add(' ');
    }
    _calenderMonth.add(_calenderWeek);
  }

  void calculateFaCalender() {
    _calenderMonth = [];
    List<String> _calenderWeek = [];

    for (int i = 1; i < getJalaliFirstDayOfMonth(_jalaliDate!).weekDay; i++) {
      _calenderWeek.add(' ');
    }

    for (int i = 1; i <= getJalaliLastDayOfMoth(_jalaliDate!).day; i++) {
      if (_calenderWeek.length < 7) {
        _calenderWeek.add('$i');
      } else {
        _calenderMonth.add(_calenderWeek);
        _calenderWeek = [];
        _calenderWeek.add('$i');
      }
    }

    for (int i = getJalaliLastDayOfMoth(_jalaliDate!).weekDay; i < 7; i++) {
      _calenderWeek.add(' ');
    }
    _calenderMonth.add(_calenderWeek);
  }

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        decoration: widget.decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: widget.background ?? Colors.white,
              border: Border.all(width: 1, color: widget.borderColor ?? Colors.black),
            ),
        child: Column(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {},
                    child: Text(
                      LanguageState.language == Language.en ? '${_gregorianDate!.formatter.mN} ${_gregorianDate!.formatter.yyyy}' : '${_jalaliDate!.formatter.mN} ${_jalaliDate!.formatter.yyyy}'.withPersianNumbers(),
                      style: widget.yearStyle ?? const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                    ),
                  )),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    tooltip: Languages.of(context).meetingCalenderNextMonth,
                    icon: Icon(LanguageState.language == Language.en ? FeatherIcons.chevronLeft : FeatherIcons.chevronRight, size: 36, color: widget.primaryColorController ?? const Color(0xFF00BBD0)),
                    onPressed: () {
                      setState(() {
                        _gregorianDate = previousMonthGregorian(_gregorianDate!);
                        _jalaliDate = previousMonthJalali(_jalaliDate!);
                        if (LanguageState.language == Language.en) {
                          calculateEnCalender();
                        } else {
                          calculateFaCalender();
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    tooltip: Languages.of(context).meetingCalenderPrevMonth,
                    icon: Icon(LanguageState.language == Language.en ? FeatherIcons.chevronRight : FeatherIcons.chevronLeft, size: 36, color: widget.primaryColorController ?? const Color(0xFF00BBD0)),
                    onPressed: () {
                      setState(() {
                        _gregorianDate = nextMonthGregorian(_gregorianDate!);
                        _jalaliDate = nextMonthJalali(_jalaliDate!);
                        if (LanguageState.language == Language.en) {
                          calculateEnCalender();
                        } else {
                          calculateFaCalender();
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  if (widget.showSwitchToMaximum!)
                    IconButton(
                        tooltip: Languages.of(context).meetingMinCalenderMaximumSizeTooltipMessage,
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                elevation: 0,
                                backgroundColor: Colors.grey.shade900.withOpacity(0.4),
                                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                  return Material(
                                    child: DialogFrameWidget(
                                      headerColor: AppTheme.colorBox('meeting_color_four'),
                                      headerHeight: 80,
                                      background: AppTheme.colorBox('meeting_color_eight'),
                                      child: BlocProvider(
                                        create: (context) => CalendarBloc(context.read<MeetingApiRepository>()),
                                        child: CalendarScreen(
                                          scaffoldKey: widget.scaffoldKey,
                                          person: widget.person,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              );
                            },
                            barrierColor: Colors.transparent,
                          ).then((value) {
                            context.read<MeetingBloc>().add(RetrieveMeetingEvent(DateTime.now(),DateTime.now()));
                            context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                            context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: DateTime.now(),toDate: DateTime.now()));
                            context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: DateTime.now(),toDate: DateTime.now()));
                            if (value != null) {}
                          });
                        },
                        icon: Icon(FeatherIcons.maximize, size: 18, color: widget.primaryColorController ?? const Color(0xFF00BBD0)),
                    ),
                  const SizedBox(
                    width: 8.0,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: SizedBox(
                height: 40,
                child: Row(
                  children: LanguageState.language == Language.en
                      ? [
                          Expanded(child: Center(child: Text('MON', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('TUH', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('WED', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('THU', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('FRI', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('SAT', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(
                              child: Center(
                                  child:
                                      Text('SUN', style: widget.dayWeekNameStyle != null ? widget.dayWeekNameStyle!.copyWith(color: Colors.red.shade800) : TextStyle(color: Colors.red.shade800, fontSize: 15, fontWeight: FontWeight.w600)))),
                        ]
                      : [
                          Expanded(child: Center(child: Text('شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('۱ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('۲ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('۳ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('۴ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(child: Center(child: Text('۵ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600)))),
                          Expanded(
                              child: Center(
                                  child:
                                      Text('جمعه', style: widget.dayWeekNameStyle != null ? widget.dayWeekNameStyle!.copyWith(color: Colors.red.shade800) : TextStyle(color: Colors.red.shade800, fontSize: 15, fontWeight: FontWeight.w600)))),
                        ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      Widget child = getRow(_calenderMonth[index]);
                      return SizedBox(
                        height: (constraints.maxHeight - 120) / _calenderMonth.length,
                        child: child,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox();
                    },
                    itemCount: _calenderMonth.length),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget getRow(List<String> items) {
    List<Widget> children = [];
    for (String item in items) {
      if (LanguageState.language == Language.en) {
        if (_gregorianDate!.year == _gregorianCurrentDay!.year && _gregorianDate!.month == _gregorianCurrentDay!.month && int.tryParse(item) == _gregorianCurrentDay!.day) {
          children.add(Expanded(
              child: Tooltip(
            message: Languages.of(context).meetingCalenderCurrentDay,
            child: InkWell(
                onTap: () {
                  DateTime dateTime = _gregorianDate!.withDay(int.parse(item)).toDateTime();
                  widget.change(dateTime);

                  context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                  context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                  context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                  context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                  setState(() {
                    _selectedDay = dateTime;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: widget.currentDayColors ?? [const Color(0xFF030F34), const Color(0xFF016683), const Color(0xFF00BBD0)],
                      ),
                    ),
                    child: Center(child: Text(item, style: widget.currentDayStyle ?? const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))))),
          )));
        } else {
          if (_gregorianDate!.year == _selectedDay!.toGregorian().year && _gregorianDate!.month == _selectedDay!.toGregorian().month && int.tryParse(item) == _selectedDay!.toGregorian().day) {
            children.add(Expanded(
                child: InkWell(
                    onTap: () {
                      DateTime dateTime = _gregorianDate!.withDay(int.parse(item)).toDateTime();
                      widget.change(dateTime);
                      context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                      context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                      context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                      context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                      setState(() {
                        _selectedDay = dateTime;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: widget.currentDayColors != null ? widget.currentDayColors!.last : const Color(0xFF00BBD0),
                          ),
                        ),
                        child: Center(child: Text(item, style: widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700)))))));
          } else {
            children.add(Expanded(
                child: InkWell(
                    onTap: () {
                      DateTime dateTime = _gregorianDate!.withDay(int.parse(item)).toDateTime();
                      widget.change(dateTime);
                      context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                      context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                      context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                      context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                      setState(() {
                        _selectedDay = dateTime;
                      });
                    },
                    child: Center(child: Text(item, style: widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))))));
          }
        }
      } else {
        if (_jalaliDate!.year == _jalaliCurrentDay!.year && _jalaliDate!.month == _jalaliCurrentDay!.month && int.tryParse(item) == _jalaliCurrentDay!.day) {
          children.add(Expanded(
              child: Tooltip(
            message: Languages.of(context).meetingCalenderCurrentDay,
            child: InkWell(
                onTap: () {
                  DateTime dateTime = _jalaliDate!.withDay(int.parse(item)).toDateTime();
                  widget.change(dateTime);
                  context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                  context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                  context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                  context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                  setState(() {
                    _selectedDay = dateTime;
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: widget.currentDayColors ?? [const Color(0xFF030F34), const Color(0xFF016683), const Color(0xFF00BBD0)],
                      ),
                    ),
                    child: Center(child: Text(item.withPersianNumbers(), style: widget.currentDayStyle ?? const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500))))),
          )));
        } else {
          if (_jalaliDate!.year == _selectedDay!.toJalali().year && _jalaliDate!.month == _selectedDay!.toJalali().month && int.tryParse(item) == _selectedDay!.toJalali().day) {
            children.add(Expanded(
                child: InkWell(
                    onTap: () {
                      DateTime dateTime = _gregorianDate!.withDay(int.parse(item)).toDateTime();
                      widget.change(dateTime);
                      context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                      context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                      context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                      context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                      setState(() {
                        _selectedDay = dateTime;
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: widget.currentDayColors != null ? widget.currentDayColors!.last : const Color(0xFF00BBD0),
                          ),
                        ),
                        child: Center(child: Text(item.withPersianNumbers(), style: widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700)))))));
          } else {
            children.add(Expanded(
                child: GestureDetector(
                    onTap: () {
                      DateTime dateTime = _jalaliDate!.withDay(int.parse(item)).toDateTime();
                      widget.change(dateTime);
                      context.read<MeetingBloc>().add(RetrieveMeetingEvent(dateTime,dateTime));
                      context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                      context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: dateTime,toDate: dateTime));
                      context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: dateTime,toDate: dateTime));
                      setState(() {
                        _selectedDay = dateTime;
                      });
                    },
                    child: Center(child: Text(item.withPersianNumbers(), style: widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))))));
          }
        }
      }
    }
    return Row(
      children: children,
    );
  }
}
