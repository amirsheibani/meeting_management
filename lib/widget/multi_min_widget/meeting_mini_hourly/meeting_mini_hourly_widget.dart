import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/multi_min_widget/meeting_mini_hourly/bloc/meeting_hourly_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MeetingMinHourly extends StatefulWidget {
  const MeetingMinHourly({
    Key? key,
  }) : super(key: key);

  @override
  _MeetingMinHourlyState createState() => _MeetingMinHourlyState();
}

class _MeetingMinHourlyState extends State<MeetingMinHourly> {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  double _currentPage = 0.0;
  List<Widget> _pages = [];

  @override
  void initState() {
    context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: DateTime.now(),toDate: DateTime.now()));
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
    super.initState();
  }

  nextOnTap() {
    if (_pageController.page!.round() >= 0) {
      _pageController.previousPage(duration: const Duration(seconds: 1), curve: Curves.ease);
    }
  }

  backOnTap() {
    if (_pageController.page!.round() <= _pages.length - 1) {
      _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return BlocConsumer<MeetingHourlyBloc, MeetingHourlyState>(
        listener: (context, state) {
          if (state is MeetingHourlyError) {
            debugPrint('MeetingHourlyError Ex:${state.props[0]}');
          }
        },
        builder: (context, state) {
          if(state is MeetingHourlyRetrieve) {
            _pages = [];
            for (var element in state.props[0]) {
              _pages.add(MeetingMinHourlyItem(
                dateTime: DateTime.parse(element.startDate!),
                title: element.title,
              ),
              );
            }
          }
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
              border: Border.all(width: 1, color: AppTheme.colorBox('meetings_color_one') ?? Colors.black),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _pageController,
                      children: _pages,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            nextOnTap();
                          },
                          child: SizedBox(
                            height: 36,
                            width: 36,
                            child: Icon(LanguageState.language == Language.en ? FeatherIcons.chevronLeft : FeatherIcons.chevronRight, size: 36, color: AppTheme.colorBox('meeting_color_seven') ?? const Color(0xFF00BBD0)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            backOnTap();
                          },
                          child: SizedBox(
                            height: 36,
                            width: 36,
                            child: Icon(LanguageState.language == Language.en ? FeatherIcons.chevronRight : FeatherIcons.chevronLeft, size: 36, color: AppTheme.colorBox('meeting_color_seven') ?? const Color(0xFF00BBD0)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class MeetingMinHourlyItem extends StatefulWidget {
  const MeetingMinHourlyItem({
    Key? key,
    this.dateTime,
    this.title,
    this.description,
  }) : super(key: key);
  final DateTime? dateTime;

  // final TextStyle? itemTitleStyle;
  // final TextStyle? itemDescriptionStyle;
  // final TextStyle? itemDeActiveDescriptionStyle;

  final String? title;
  final String? description;

  @override
  State<MeetingMinHourlyItem> createState() => _MeetingMinHourlyItemState();
}

class _MeetingMinHourlyItemState extends State<MeetingMinHourlyItem> {
  @override
  Widget build(BuildContext context) {
    String? _title;
    Gregorian? _gregorianDate;
    Jalali? _jalaliDate;

    if (LanguageState.language == Language.en) {
      _gregorianDate = widget.dateTime!.toGregorian();
      _title = '${_gregorianDate.hour < 10 ? '0${_gregorianDate.hour}' : '${_gregorianDate.hour}'}:${_gregorianDate.minute < 10 ? '0${_gregorianDate.minute}' : '${_gregorianDate.minute}'}';
    } else {
      _jalaliDate = widget.dateTime!.toJalali();
      _title = '${_jalaliDate.hour < 10 ? '0${_jalaliDate.hour}' : '${_jalaliDate.hour}'}:${_jalaliDate.minute < 10 ? '0${_jalaliDate.minute}' : '${_jalaliDate.minute}'}';
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: MinClock(
                    dateTime: widget.dateTime,
                    strokeWidth: 1.2,
                    strokeWidthCircle: 2,
                  ),
                ),
              ),
              Text(
                _title.convertNumberWithLanguage(),
                style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Text(
            widget.title ?? '',
            style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Text(widget.description ?? '', style: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w300)),
          ),
        ),
      ],
    );
  }
}
