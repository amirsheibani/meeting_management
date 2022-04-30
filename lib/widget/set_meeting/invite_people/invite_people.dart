import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'bloc/invite_people_bloc.dart';
import 'widget/dropdown/invite_people_drop_down_widget.dart';

class InvitePeople extends StatefulWidget {
  const InvitePeople({
    Key? key,
    required this.dateTime,
    required this.location,
    required this.scaffoldKey, required this.members,
  }) : super(key: key);
  final DateTime dateTime;
  final LocationModel location;
  final List<Member> members;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _InvitePeopleState createState() => _InvitePeopleState();
}

class _InvitePeopleState extends State<InvitePeople> {
  bool plusIcon = false;
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
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Padding(
        padding: EdgeInsets.only(right: constraints.maxWidth * 0.05, left: constraints.maxWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                SizedBox(width: constraints.maxWidth * 0.03),
                SizedBox(
                  width: 16,
                  height: 16,
                  child: MinClock(
                    dateTime: widget.dateTime,
                    strokeWidth: 1.2,
                    strokeWidthCircle: 2,
                    color: AppTheme.colorBox('meeting_color_four'),
                  ),
                ),
                SizedBox(width: constraints.maxWidth * 0.01),
                Center(
                  child: Text(
                    _time.convertNumberWithLanguage(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                  ),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.03,
                ),
                Icon(
                  FeatherIcons.mapPin,
                  size: 24,
                  color: AppTheme.colorBox('meeting_color_four'),
                ),
                Center(
                  child: Text(
                    widget.location.name!.convertNumberWithLanguage(),
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                  ),
                ),
              ],
            ),
            SizedBox(height: constraints.maxHeight*0.10,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FeatherIcons.users,
                  size: 24,
                  color: AppTheme.colorBox('meeting_color_four'),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.01,
                ),
                Center(
                  child: Text(
                    Languages.of(context).meetingPeople,
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16,),
            InvitePeopleDropdownWidget(
              scaffoldKey: widget.scaffoldKey,
              validations: [],
              change: (value) {
                if (value is Member) {
                  context.read<InvitePeopleBloc>().add(MemberInviteEvent(value));
                } else if (value is PeopleGroupModel) {
                  context.read<InvitePeopleBloc>().add(GroupMemberInviteEvent(value.id!));
                }
              },
            ),
            Expanded(
              child: BlocConsumer<InvitePeopleBloc, InvitePeopleState>(
                listener: (context, state) {
                  if (state is InvitePeopleDropdownErrorState) {
                    debugPrint('member list Ex:${state.props[0]}');
                  }
                },
                builder: (context, state) {
                  if (state is MemberInviteLoadedState) {
                    for (var item in state.props[0]) {
                      if (widget.members.where((element) => element.id == item.id).isEmpty) {
                        widget.members.add(item);
                      }
                    }
                  } else if (state is MemberRemoveLoadedState) {
                    widget.members.remove(state.props[0][0]);
                  }
                  return ReorderableWrap(
                      controller: ScrollController(),
                      needsLongPressDraggable: false,
                      spacing: 8,
                      runSpacing: 4,
                      onReorder: (int oldIndex, int newIndex) {},
                      children: widget.members.map((element) {
                        return InkWell(
                            onTap: () {
                              context.read<InvitePeopleBloc>().add(MemberRemoveEvent(element));
                            },
                            onDoubleTap: () {
                              context.read<InvitePeopleBloc>().add(MemberRemoveEvent(element));
                            },
                            child: Text('${element.firstName} ${element.lastName}',
                              style: Theme.of(context).textTheme.headline6!.copyWith(
                                  color: element.type == 3 ? AppTheme.colorBox('meeting_color_eight') : AppTheme.colorBox('meeting_color_four'),
                                  fontWeight: FontWeight.w600,
                                  backgroundColor: element.type == 3 ? AppTheme.colorBox('meeting_color_four') : AppTheme.colorBox('meeting_color_seven')),
                            ),
                        );
                      }).toList());
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
