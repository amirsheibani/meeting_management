import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/metting_mini_daily/bloc/meeting_daily_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';

class MeetingMinDaily extends StatefulWidget {
  const MeetingMinDaily({
    Key? key,
  }) : super(key: key);

  @override
  _MeetingMinDailyState createState() => _MeetingMinDailyState();
}

class _MeetingMinDailyState extends State<MeetingMinDaily> {
  String _title = '';
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;

  @override
  void initState() {
    super.initState();
    context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: DateTime.now(), toDate: DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    // DateTime _dateTime = DateTime.now();
    

    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
          border: Border.all(width: 1, color: AppTheme.colorBox('meetings_color_one') ?? Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<MeetingDailyBloc, MeetingDailyState>(
            listener: (context, state) {
              if (state is MeetingDailyError) {
                debugPrint('${(state).props[0]!}');
              }
            },
            builder: (context, state) {
              if (state is MeetingDailyRetrieve) {
                List<MeetingModel> meetingList = state.props[0];
                if (LanguageState.language == Language.en) {
                  _gregorianDate = (state.props[1] as DateTime).toGregorian();
                  _title = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
                } else {
                  _jalaliDate = (state.props[1] as DateTime).toJalali();
                  _title = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          FeatherIcons.calendar,
                          size: 36,
                          color: AppTheme.colorBox('meetings_color_one') ?? Colors.black,
                        ),
                        Text(
                          _title.convertNumberWithLanguage(),
                          style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20, color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              if (meetingList[index].status == 4) {
                                return SizedBox(
                                  height: 40,
                                  child: ListTile(
                                      dense: true,
                                      title: Text(
                                        meetingList[index].title!,
                                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                            fontSize: 12, color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500, decorationColor: AppTheme.colorBox('meeting_color_ten'), decoration: TextDecoration.lineThrough),
                                      ),
                                      trailing: null),
                                );
                              } else if (meetingList[index].status == 2 || meetingList[index].status == 3 || DateTime.parse(meetingList[index].startDate!).compareTo(DateTime.now()) == -1) {
                                return SizedBox(
                                  height: 40,
                                  child: ListTile(
                                    dense: true,
                                    title: Text(meetingList[index].title!, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12, color: getColor(meetingList[index].priority).withAlpha(92), fontWeight: FontWeight.w500)),
                                    trailing: Icon(
                                      FeatherIcons.edit,
                                      size: 12,
                                      color: getColor(meetingList[index].priority).withAlpha(92),
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox(
                                  height: 40,
                                  child: ListTile(
                                      dense: true,
                                      title: Text(meetingList[index].title!, style: Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 12, color: getColor(meetingList[index].priority), fontWeight: FontWeight.w500)),
                                      trailing: Icon(
                                        FeatherIcons.edit,
                                        size: 12,
                                        color: getColor(meetingList[index].priority),
                                      )),
                                );
                              }
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox(
                                height: 4,
                              );
                            },
                            itemCount: meetingList.length),
                      ),
                    ),
                  ],
                );
              }
              return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_four'), strokeWidth: 1.5));
            },
          ),
        ));
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
