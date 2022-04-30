import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/bloc/calendar_bloc.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/meetings/widget/bloc/invitees_bloc/invitees_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/location/bloc/location_bloc.dart';
import 'package:meeting_management/widget/set_meeting/bloc/set_meeting_bloc.dart';
import 'package:meeting_management/widget/set_meeting/edit_meeting.dart';
import 'package:meeting_management/widget/set_meeting/invite_people/bloc/invite_people_bloc.dart';
import 'package:meeting_management/widget/set_meeting/invite_people/widget/dropdown/bloc/invite_people_dropdown_bloc.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/asset_drop_down/bloc/set_asset_bloc.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/location_drop_down/bloc/location_dropdown_bloc.dart';
import 'package:meeting_management/widget/set_meeting/set_meeting.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'bloc/calendar_bloc.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen(
      {Key? key,
      this.background,
      this.borderColor,
      this.titleBackground,
      this.primaryColorController,
      this.secondaryColorController,
      this.yearStyle,
      this.currentDayColors,
      this.currentDayStyle,
      this.dayStyle,
      this.dayWeekNameStyle,
      this.rowsColor,
      required this.scaffoldKey,
      required this.person})
      : super(key: key);
  final Color? background;
  final Color? borderColor;
  final Color? titleBackground;
  final Color? primaryColorController;
  final Color? secondaryColorController;
  final TextStyle? yearStyle;
  final List<Color>? currentDayColors;
  final TextStyle? currentDayStyle;
  final TextStyle? dayStyle;
  final TextStyle? dayWeekNameStyle;
  final Color? rowsColor;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Person person;

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  List<List<String>> _calenderMonth = [];
  Gregorian? _gregorianDate;
  Gregorian? _gregorianCurrentDay;

  Jalali? _jalaliDate;
  Jalali? _jalaliCurrentDay;

  List<MeetingModel> _meetingList = [];

  late DateTime _datetime;
  late DateTime _datetimeSelect;

  @override
  void initState() {
    initDate();
    context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return BlocConsumer<CalendarBloc, CalendarState>(
        listener: (context, state) {
          if (state is CalendarError) {
            debugPrint('meeting list Ex:${state.props[0]}');
          } else if (state is CalendarRemoveMeeting) {
            context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
          }
        },
        builder: (context, state) {
          if (state is CalendarRetrieve) {
            _meetingList = state.props[0];
          }
          if (LanguageState.language == Language.en) {
            calculateEnCalender();
          } else {
            calculateFaCalender();
          }
          return Padding(
            padding: EdgeInsets.only(right: constraints.maxWidth * 0.1, left: constraints.maxWidth * 0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _gregorianDate = previousMonthGregorian(_gregorianDate!);
                                    _jalaliDate = previousMonthJalali(_jalaliDate!);
                                    if (LanguageState.language == Language.en) {
                                      _datetime = _gregorianDate!.toDateTime();
                                    } else {
                                      _datetime = _jalaliDate!.toDateTime();
                                    }
                                    context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
                                  },
                                  child: Center(
                                      child: Text(
                                    Languages.of(context).meetingCalenderPrevMonth,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                              VerticalDivider(width: 2.0, color: AppTheme.colorBox('meeting_color_nine'), indent: 4.0, endIndent: 4.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _datetime = DateTime.now();
                                    _gregorianDate = _datetime.toGregorian();
                                    _gregorianCurrentDay = _datetime.toGregorian();
                                    _jalaliDate = _datetime.toJalali();
                                    _jalaliCurrentDay = _datetime.toJalali();
                                    context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
                                  },
                                  child: Center(
                                      child: Text(
                                    Languages.of(context).meetingCalenderCurrentDay,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_seven'), fontSize: 15, fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                              VerticalDivider(width: 2.0, color: AppTheme.colorBox('meeting_color_nine'), indent: 4.0, endIndent: 4.0),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    _gregorianDate = nextMonthGregorian(_gregorianDate!);
                                    _jalaliDate = nextMonthJalali(_jalaliDate!);
                                    if (LanguageState.language == Language.en) {
                                      _datetime = _gregorianDate!.toDateTime();
                                    } else {
                                      _datetime = _jalaliDate!.toDateTime();
                                    }
                                    context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
                                  },
                                  child: Center(
                                      child: Text(
                                    Languages.of(context).meetingCalenderNextMonth,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w500),
                                  )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {},
                            child: Center(
                              child: Text(
                                LanguageState.language == Language.en ? '${_gregorianDate!.formatter.mN} ${_gregorianDate!.formatter.yyyy}' : '${_jalaliDate!.formatter.mN} ${_jalaliDate!.formatter.yyyy}'.convertNumberWithLanguage(),
                                style: widget.yearStyle ?? const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 45,
                          child: ElevatedButton.icon(
                            icon: Icon(
                              FeatherIcons.plus,
                              size: 16,
                              color: AppTheme.colorBox('meeting_color_eight'),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_four')),
                            ),
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
                                      return DialogFrameWidget(
                                          widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.55,
                                          heightScale: 0.85,
                                          leading: Icon(FeatherIcons.clock, size: 37, color: AppTheme.colorBox('meeting_color_eight')),
                                          title: Text(Languages.of(context).meetingSetMeetingTitle, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                          headerColor: AppTheme.colorBox('meeting_color_four'),
                                          headerHeight: 80,
                                          background: AppTheme.colorBox('meeting_color_eight'),
                                          child: MultiBlocProvider(
                                            providers: [
                                              BlocProvider(create: (context) => LocationDropdownBloc(context.read<LocationRepository>())),
                                              BlocProvider(create: (context) => InvitePeopleDropdownBloc(context.read<MemberRepository>())),
                                              BlocProvider(create: (context) => InvitePeopleBloc(context.read<MemberRepository>())),
                                              BlocProvider(create: (context) => SetMeetingBloc(context.read<MeetingApiRepository>())),
                                              BlocProvider(create: (context) => SetAssetBloc(context.read<AssetsRepository>())),
                                            ],
                                            child: SetMeeting(
                                              scaffoldKey: widget.scaffoldKey,
                                              dateTime: _datetimeSelect,
                                              person: widget.person,
                                            ),
                                          )
                                          // child:  SetTime(dateTime: DateTime(2022, 1, 1, 14, 10,30),),
                                          );
                                    }),
                                  );
                                },
                                barrierColor: Colors.transparent,
                              ).then((value) {
                                context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
                              });
                            },
                            label: Text(
                              Languages.of(context).meetingCalenderAddNewMeeting,
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight')),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(16), topLeft: Radius.circular(16)),
                      border: Border.all(width: 1, color: AppTheme.colorBox('meeting_color_nine')),
                    ),
                    child: Row(
                      children: LanguageState.language == Language.en
                          ? [
                              Expanded(
                                  child: Container(
                                child: Center(child: Text('MON', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                child: Center(child: Text('TUH', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                child: Center(child: Text('WED', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                child: Center(child: Text('THU', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                child: Center(child: Text('FRI', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                  child: Container(
                                decoration: BoxDecoration(
                                    border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')), right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen'))), color: Colors.red.shade100),
                                child: Center(child: Text('SAT', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))),
                              )),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      // border: Border(left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen'))),
                                      color: Colors.red.shade200,
                                      borderRadius: const BorderRadius.only(topRight: Radius.circular(16))),
                                  child: Center(
                                    child: Text('SUN', style: widget.dayWeekNameStyle != null ? widget.dayWeekNameStyle!.copyWith(color: Colors.red.shade800) : TextStyle(color: Colors.red.shade800, fontSize: 15, fontWeight: FontWeight.w600)),
                                  ),
                                ),
                              ),
                            ]
                          : [
                              Expanded(child: Container(child: Center(child: Text('شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                      child: Center(child: Text('۱ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                      child: Center(child: Text('۲ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                      child: Center(child: Text('۳ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                      child: Center(child: Text('۴ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(border: Border(right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')))),
                                      child: Center(child: Text('۵ شنبه', style: widget.dayWeekNameStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600))))),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16)),
                                        // border: Border(
                                        //     right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                                        // ),
                                        color: Colors.red.shade200,
                                      ),
                                      child: Center(
                                          child:
                                              Text('جمعه', style: widget.dayWeekNameStyle != null ? widget.dayWeekNameStyle!.copyWith(color: Colors.red.shade800) : TextStyle(color: Colors.red.shade800, fontSize: 15, fontWeight: FontWeight.w600))))),
                            ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          Widget child = getRow(_calenderMonth[index], index + 1 == _calenderMonth.length);
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
        },
      );
    });
  }

  void initDate() {
    _datetime = DateTime.now();
    _gregorianDate = _datetime.toGregorian();
    _gregorianCurrentDay = _datetime.toGregorian();
    _jalaliDate = _datetime.toJalali();
    _jalaliCurrentDay = _datetime.toJalali();
    _datetimeSelect = _datetime;
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

  void onChange(DateTime dateTime) {}

  Widget getRow(List<String> items, bool lastRow) {
    List<Widget> children = [];
    bool f = false;
    bool l = false;
    for (int index = 0; index < items.length; index++) {
      if (LanguageState.language == Language.en) {
        if (_gregorianDate!.year == _gregorianCurrentDay!.year && _gregorianDate!.month == _gregorianCurrentDay!.month && int.tryParse(items[index]) == _gregorianCurrentDay!.day) {
          children.add(
            Expanded(
              child: InkWell(
                onTap: () {
                  _datetimeSelect = _gregorianDate!.withDay(int.parse(items[index])).toDateTime();
                  onChange(_datetimeSelect);
                },
                child: Container(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    decoration: BoxDecoration(
                      color: index == 6
                          ? Colors.red.shade200
                          : LanguageState.language == Language.en
                              ? index == 5
                                  ? Colors.red.shade100
                                  : null
                              : null,
                      // borderRadius: true ? const BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)):null,
                      border: index + 1 == items.length
                          ? Border(
                              left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                              right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                              bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            )
                          : Border(
                              left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                              bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            ),
                    ),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                padding: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF00BBD0), width: 1.0)),
                                child: Text(items[index], style: widget.currentDayStyle ?? const TextStyle(color: Color(0xFF00BBD0), fontSize: 15, fontWeight: FontWeight.w500)))),
                        getMeetingAtDay(items[index], widget.currentDayStyle ?? const TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                      ],
                    )),
              ),
            ),
          );
        } else {
          children.add(
            Expanded(
              child: InkWell(
                onTap: () {
                  _datetimeSelect = _gregorianDate!.withDay(int.parse(items[index])).toDateTime();
                  onChange(_datetimeSelect);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: index == 6
                        ? Colors.red.shade200
                        : LanguageState.language == Language.en
                            ? index == 5
                                ? Colors.red.shade100
                                : null
                            : null,
                    // borderRadius: true ? const BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)):null,
                    border: index + 1 == items.length
                        ? Border(
                            left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          )
                        : Border(
                            left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          ),
                  ),
                  child: Column(
                    children: [
                      Align(alignment: Alignment.topRight, child: Text(items[index], style: widget.currentDayStyle ?? const TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500))),
                      getMeetingAtDay(items[index], widget.currentDayStyle ?? const TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      } else {
        if (_jalaliDate!.year == _jalaliCurrentDay!.year && _jalaliDate!.month == _jalaliCurrentDay!.month && int.tryParse(items[index]) == _jalaliCurrentDay!.day) {
          children.add(
            Expanded(
              child: InkWell(
                onTap: () {
                  _datetimeSelect = _jalaliDate!.withDay(int.parse(items[index])).toDateTime();
                  onChange(_datetimeSelect);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: index == 6
                        ? Colors.red.shade200
                        : LanguageState.language == Language.en
                            ? index == 5
                                ? Colors.red.shade100
                                : null
                            : null,
                    // borderRadius: lastRow ? const BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)): null,
                    border: index + 1 == items.length
                        ? Border(
                            // left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          )
                        : Border(
                            // left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          ),
                  ),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF00BBD0), width: 1.0)),
                            child: Text(items[index].convertNumberWithLanguage(), style: widget.currentDayStyle ?? const TextStyle(color: Color(0xFF00BBD0), fontSize: 15, fontWeight: FontWeight.w500)),
                          )),
                      getMeetingAtDay(items[index], widget.currentDayStyle ?? const TextStyle(color: Color(0xFF000000), fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          children.add(
            Expanded(
              child: InkWell(
                onTap: () {
                  _datetimeSelect = _jalaliDate!.withDay(int.parse(items[index])).toDateTime();
                  onChange(_datetimeSelect);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  decoration: BoxDecoration(
                    color: index == 6
                        ? Colors.red.shade200
                        : LanguageState.language == Language.en
                            ? index == 5
                                ? Colors.red.shade100
                                : null
                            : null,
                    // borderRadius: lastRow ? const BorderRadius.only(bottomRight: Radius.circular(16),bottomLeft: Radius.circular(16)):null,
                    border: index + 1 == items.length
                        ? Border(
                            right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            left: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          )
                        : Border(
                            right: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                            bottom: BorderSide(width: 1, color: AppTheme.colorBox('meeting_color_thirteen')),
                          ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Text(items[index].convertNumberWithLanguage(), style: widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700)),
                      ),
                      getMeetingAtDay(items[index], widget.dayStyle ?? const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }
    }
    return Row(
      children: children,
    );
  }

  Widget getMeetingAtDay(String item, TextStyle textStyle) {
    if (item != '' && item != ' ') {
      DateTime _dateTime;
      List<MeetingModel> _meetingShowList = [];
      if (LanguageState.language == Language.en) {
        _dateTime = _gregorianDate!.withDay(int.parse(item)).toDateTime();
      } else {
        _dateTime = _jalaliDate!.withDay(int.parse(item)).toDateTime();
      }
      for (var element in _meetingList) {
        if (element.startDate != null) {
          if (DateTime.parse(element.startDate!).year == _dateTime.year && DateTime.parse(element.startDate!).month == _dateTime.month && DateTime.parse(element.startDate!).day == _dateTime.day) {
            _meetingShowList.add(element);
            //   _titles.add(element.title ?? Languages.of(context).empty);
            //   _tooltips.add(element.description ?? Languages.of(context).empty);
            //   if(element.priority == 0){
            //     _colors.add(AppTheme.colorBox('meeting_color_eight'));
            //   }else if(element.priority == 1){
            //     _colors.add(AppTheme.colorBox('meeting_color_seven'));
            //   }else if(element.priority == 2){
            //     _colors.add(AppTheme.colorBox('meeting_color_four'));
            //   }else if(element.priority == 3){
            //     _colors.add(AppTheme.colorBox('meeting_color_ten'));
            //   }
            // }
          }
        }
      }
      return Expanded(
        child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onDoubleTap: () {
                  //TODO Show edit event dialog
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
                          return DialogFrameWidget(
                              widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.55,
                              heightScale: 0.65,
                              leading: Icon(FeatherIcons.clock, size: 37, color: AppTheme.colorBox('meeting_color_eight')),
                              title: Text(Languages.of(context).meetingSetMeetingTitle, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                              headerColor: AppTheme.colorBox('meeting_color_four'),
                              headerHeight: 80,
                              background: AppTheme.colorBox('meeting_color_eight'),
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider(create: (context) => LocationBloc(context.read<LocationRepository>())),
                                  BlocProvider(create: (context) => InvitePeopleDropdownBloc(context.read<MemberRepository>())),
                                  BlocProvider(create: (context) => InvitePeopleBloc(context.read<MemberRepository>())),
                                  BlocProvider(create: (context) => SetMeetingBloc(context.read<MeetingApiRepository>())),
                                  BlocProvider(create: (context) => SetAssetBloc(context.read<AssetsRepository>())),
                                  BlocProvider(create: (context) => AssetBloc(context.read<AssetsRepository>())),
                                  BlocProvider(create: (context) => InviteesBloc(context.read<MeetingApiRepository>())),
                                  BlocProvider(create: (context) => CalendarBloc(context.read<MeetingApiRepository>())),
                                ],
                                child: EditMeetingWidget(
                                  scaffoldKey: widget.scaffoldKey,
                                  meetingModel: _meetingShowList[index],
                                  dateTime: _datetimeSelect,
                                  person: widget.person,
                                ),
                              )
                            // child:  SetTime(dateTime: DateTime(2022, 1, 1, 14, 10,30),),
                          );
                        }),
                      );
                    },
                    barrierColor: Colors.transparent,
                  ).then((value) {
                    context.read<CalendarBloc>().add(CalendarMeetingEvent(fromDate: DateTime(_datetime.year, _datetime.month, 1), toDate: DateTime(_datetime.year, _datetime.month + 1, 0)));
                  });
                },
                child: Tooltip(
                  verticalOffset: 0.0,
                  message: _meetingShowList[index].description ?? Languages.of(context).empty,
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      color: getColor(_meetingShowList[index].priority),
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0, left: 4.0),
                      child: Text(
                        _meetingShowList[index].title ?? Languages.of(context).empty,
                        style: Theme.of(context).textTheme.bodyText1!.apply(
                              color: AppTheme.colorBox('meeting_color_eight'),
                            ),
                      ),
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 2);
            },
            itemCount: _meetingShowList.length),
      );
    }
    return const SizedBox();
  }

  Color getColor(int? value) {
    Color color = Colors.grey.shade600;
    if (value != null) {
      if (value == 0) {
        color = AppTheme.colorBox('meeting_color_eight');
      } else if (value == 1) {
        color = AppTheme.colorBox('meeting_color_seven');
      } else if (value == 2) {
        color = AppTheme.colorBox('meeting_color_four');
      } else if (value == 3) {
        color = AppTheme.colorBox('meeting_color_ten');
      }
    }
    return color;
  }
}
