import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/meeting/model/invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/min_calendar.dart';
import 'package:meeting_management/widget/set_meeting/bloc/set_meeting_bloc.dart';
import 'package:meeting_management/widget/set_meeting/details/details.dart';
import 'package:meeting_management/widget/set_meeting/invite_people/invite_people.dart';
import 'package:meeting_management/widget/set_meeting/set_location_and_asset/set_location.dart';
import 'package:meeting_management/widget/set_meeting/set_time/set_time.dart';

import 'widget/priority_widget.dart';

class SetMeeting extends StatefulWidget {
  const SetMeeting({Key? key, required this.scaffoldKey, required this.dateTime, required this.person}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final DateTime dateTime;
  final Person person;

  @override
  _SetMeetingState createState() => _SetMeetingState();
}

class _SetMeetingState extends State<SetMeeting> {
  DateTime? _dateTime;
  SetDateState _setDateState = SetDateState.time;
  LocationModel? _location;
  List<AssetModel>? _assetModel;
  final List<Member> _members = [];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  PriorityStatus _priorityStatus = PriorityStatus.none;

  @override
  void initState() {
    _dateTime = widget.dateTime;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      Widget _widget = const SizedBox();
      switch (_setDateState) {
        case SetDateState.date:
          _widget = MinCalendar(
            defaultDateTime: _dateTime,
            showSwitchToMaximum: false,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
              color: AppTheme.colorBox('meeting_color_eight'),
              border: Border.all(
                width: 1,
                color: AppTheme.colorBox('meeting_color_eight'),
              ),
            ),
            borderColor: AppTheme.colorBox('meetings_color_one'),
            primaryColorController: AppTheme.colorBox('meeting_color_four'),
            yearStyle: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 20, fontWeight: FontWeight.w600),
            currentDayColors: [AppTheme.colorBox('meeting_color_four'), AppTheme.colorBox('meetings_color_three'), AppTheme.colorBox('meeting_color_seven')],
            dayStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w700),
            dayWeekNameStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w600),
            currentDayStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 15, fontWeight: FontWeight.w500),
            change: (date) {
              setState(() {
                _dateTime = date;
                _setDateState = SetDateState.time;
              });
            },
            person: widget.person,
            scaffoldKey: widget.scaffoldKey,
          );
          break;
        case SetDateState.time:
          _widget = SetTime(
            dateTime: _dateTime!,
            updateDateTime: (value) {
              _dateTime = value;
            },
          );
          break;
        case SetDateState.location:
          _widget = SetLocationAndAsset(
            dateTime: _dateTime!,
            scaffoldKey: widget.scaffoldKey,
            changeLocation: (value) {
              _location = value;
            },
            changeAsset: (value) {
              _assetModel = value;
            },
          );
          break;
        case SetDateState.invite:
          _widget = InvitePeople(
            dateTime: _dateTime!,
            scaffoldKey: widget.scaffoldKey,
            location: _location!,
            members: _members,
          );
          break;
        case SetDateState.details:
          _widget = Details(
              dateTime: _dateTime!,
              location: _location!,
              members: _members,
              titleController: _titleController,
              descriptionController: _descriptionController,
              priorityStatus: (value) {
                _priorityStatus = value;
              });
          break;
      }
      return BlocListener<SetMeetingBloc, SetMeetingState>(
        listener: (context, state) {
          if (state is MeetingError) {
            debugPrint('meeting create Ex:${state.props[0]}');
          } else if (state is MeetingAddNew) {
            Navigator.of(context).pop();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
            color: AppTheme.colorBox('meeting_color_eight'),
          ),
          child: Padding(
            padding: EdgeInsets.only(right: constraints.maxWidth * 0.05, left: constraints.maxWidth * 0.05),
            child: Column(
              children: [
                const SizedBox(height: 8.0),
                Expanded(
                  child: _widget,
                ),
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(width: constraints.maxWidth * 0.04),
                      SizedBox(
                        width: constraints.maxWidth * 0.13,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () {
                            switch (_setDateState) {
                              case SetDateState.date:
                                setState(() {
                                  _setDateState = SetDateState.date;
                                });
                                break;
                              case SetDateState.time:
                                setState(() {
                                  _setDateState = SetDateState.date;
                                });
                                break;
                              case SetDateState.location:
                                setState(() {
                                  _setDateState = SetDateState.time;
                                });
                                break;
                              case SetDateState.invite:
                                setState(() {
                                  _setDateState = SetDateState.location;
                                });
                                break;
                              case SetDateState.details:
                                setState(() {
                                  _setDateState = SetDateState.invite;
                                });
                                break;
                            }
                          },
                          child: Text(
                            Languages.of(context).meetingButtonPrev,
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w500),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            side: MaterialStateProperty.all<BorderSide>(
                              BorderSide(
                                width: 1.0,
                                color: AppTheme.colorBox('meeting_color_four'),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_eight')),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: constraints.maxWidth * 0.13,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            Languages.of(context).meetingButtonSkip,
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_nine')),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.01,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.13,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () {
                            switch (_setDateState) {
                              case SetDateState.date:
                                setState(() {
                                  _setDateState = SetDateState.time;
                                });
                                break;
                              case SetDateState.time:
                                setState(() {
                                  _setDateState = SetDateState.location;
                                });
                                break;
                              case SetDateState.location:
                                if (_location != null) {
                                  setState(() {
                                    _setDateState = SetDateState.invite;
                                  });
                                }
                                break;
                              case SetDateState.invite:
                                setState(() {
                                  _setDateState = SetDateState.details;
                                });
                                break;
                              case SetDateState.details:
                                final dateFormat = DateFormat('yyyy-MM-ddThh:mm:ss');
                                MeetingModel _meetingModel = MeetingModel();
                                _meetingModel.title = _titleController.text;
                                _meetingModel.description = _descriptionController.text;
                                _meetingModel.approximateDuration = 120;
                                _meetingModel.startDate = dateFormat.format(_dateTime!);
                                // _meetingModel.endDate =  dateFormat.format(_dateTime!.add(const Duration(minutes: 120)));
                                _meetingModel.hostId = widget.person.id;
                                int pid = 0;
                                if (_priorityStatus == PriorityStatus.low) {
                                  pid = 1;
                                } else if (_priorityStatus == PriorityStatus.medium) {
                                  pid = 2;
                                } else if (_priorityStatus == PriorityStatus.high) {
                                  pid = 3;
                                }
                                _meetingModel.priority = pid;
                                _meetingModel.typeId = 1;
                                _meetingModel.code = '1';
                                _meetingModel.locationId = _location!.id;
                                _meetingModel.onlineMeetingSoftware = null;
                                List<InviteesModel> inviteList = [];
                                for (var element in _members) {
                                  inviteList.add(InviteesModel(personId: element.type == 3 ? element.id : null, partyPersonId: element.type == 1 ? element.id : null));
                                }

                                _meetingModel.invitees = inviteList;
                                if (_assetModel != null) {
                                  List<int> items = [];
                                  for (var element in _assetModel!) {
                                    items.add(element.id!);
                                  }
                                  _meetingModel.assets = items;
                                }

                                context.read<SetMeetingBloc>().add(AddNewMeetingEvent(meetingModel: _meetingModel));

                                break;
                            }
                          },
                          child: Text(SetDateState.details == _setDateState ? Languages.of(context).meetingButtonSave : Languages.of(context).meetingButtonNext,
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300)),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            alignment: Alignment.center,
                            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_four')),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

enum SetDateState { date, time, location, invite, details }
