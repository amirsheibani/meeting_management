import 'dart:convert';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/bloc/language_bloc.dart';
import 'package:meeting_management/language/bloc/language_event.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/main.dart';
import 'package:meeting_management/screen/dashboard/model/sequence_items.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/bloc/calendar_bloc.dart';
import 'package:meeting_management/widget/calendar/calendar_screen.dart';
import 'package:meeting_management/widget/calendar/min_calendar.dart';
import 'package:meeting_management/widget/invitation_meeting/bloc/pending_bloc/meeting_pending_bloc.dart';
import 'package:meeting_management/widget/invitation_meeting/invitation_meetings.dart';
import 'package:meeting_management/widget/meetings/bloc/meeting_bloc.dart';
import 'package:meeting_management/widget/meetings/meetings.dart';
import 'package:meeting_management/widget/message/messages.dart';
import 'package:meeting_management/widget/multi_min_widget/meeting_mini_hourly/bloc/meeting_hourly_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/metting_mini_daily/bloc/meeting_daily_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/multi_mini_assets_location_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/multi_mini_meeting_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/multi_mini_people_group_widget.dart';
import 'package:meeting_management/widget/notes/notes.dart';
import 'package:meeting_management/widget/notification/bloc/notification_bloc.dart';
import 'package:meeting_management/widget/notification/model/notification_data.dart';
import 'package:meeting_management/widget/notification/notification.dart';
import 'package:meeting_management/widget/notification/repository/notification_repository.dart';
import 'package:reorderables/reorderables.dart';

class MeetingHomeScreen extends StatefulWidget {
  const MeetingHomeScreen({
    Key? key,
    required this.scaffoldKey,
    required this.person,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Person person;

  @override
  _MeetingHomeScreenState createState() => _MeetingHomeScreenState();
}

class _MeetingHomeScreenState extends State<MeetingHomeScreen> {
  List<Widget> _list = [];
  List<SequenceItems> _sequenceItems = [];

  double? _width;
  double? _childAspectRatio;

  Future<void> loadSequence() async {
    Map<String, String> value = await LocalStorage.instance.readString("sequence_items", session: false);
    if (value['sequence_items'] != '') {
      for (var item in json.decode(value['sequence_items']!)) {
        _sequenceItems.add(SequenceItems.fromJson(item));
      }
    } else {
      List<SequenceItems> sequenceList = [
        SequenceItems(name: 'InvitationMeetings', id: '0'),
        SequenceItems(name: 'MultiMiniMeetingWidget', id: '1'),
        SequenceItems(name: 'MinCalender', id: '2'),
        SequenceItems(name: 'Messages', id: '3'),
        SequenceItems(name: 'Notes', id: '4'),
        SequenceItems(name: 'Meetings', id: '5'),
        SequenceItems(name: 'MultiMiniPeopleGroupWidget', id: '6'),
        SequenceItems(name: 'MultiMiniAssetsLocationWidget', id: '7'),
      ];
      await LocalStorage.instance.saveString({"sequence_items": json.encode(sequenceList)}, session: false);
      _sequenceItems = sequenceList;
      setState(() {});
    }
  }

  loadWidget() async {
    _sequenceItems.sort((a, b) => int.parse(a.id!).compareTo(int.parse(b.id!)));
    _list = [];
    for (var item in _sequenceItems) {
      if (item.name == 'InvitationMeetings') {
        _list.add(InvitationMeetings(
          scaffoldKey: widget.scaffoldKey,
          person: widget.person,
          title: Languages.of(context).meetingInvitation,
          textStyle: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one')),
          meetingButtonOnTap: () {
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
                      child: BlocProvider(
                        create: (context) => CalendarBloc(context.read<MeetingApiRepository>()),
                        child: CalendarScreen(
                          scaffoldKey: widget.scaffoldKey,
                          person: widget.person,
                        ),
                      ),
                    );
                  }),
                );
              },
              barrierColor: Colors.transparent,
            ).then((value) {
              context.read<MeetingBloc>().add(RetrieveMeetingEvent(DateTime.now(), DateTime.now()));
              context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
              context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: DateTime.now(), toDate: DateTime.now()));
              context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: DateTime.now(), toDate: DateTime.now()));
              if (value != null) {}
            });
          },
        ));
      } else if (item.name == 'MultiMiniMeetingWidget') {
        _list.add(const MultiMiniMeetingWidget());
      } else if (item.name == 'MultiMiniPeopleGroupWidget') {
        _list.add(MultiMiniPeopleGroupWidget(
          person: widget.person,
        ));
      } else if (item.name == 'MultiMiniAssetsLocationWidget') {
        _list.add(const MultiMiniAssetsLocationWidget());
      } else if (item.name == 'MinCalender') {
        _list.add(MinCalendar(
          // background: AppTheme.colorBox('meeting_color_eight'),
          borderColor: AppTheme.colorBox('meetings_color_one'),
          primaryColorController: AppTheme.colorBox('meeting_color_seven'),
          yearStyle: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 20, fontWeight: FontWeight.w600),
          currentDayColors: [AppTheme.colorBox('meeting_color_four'), AppTheme.colorBox('meetings_color_three'), AppTheme.colorBox('meeting_color_seven')],
          dayStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w700),
          dayWeekNameStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontSize: 15, fontWeight: FontWeight.w600),
          currentDayStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 15, fontWeight: FontWeight.w500),
          change: (date) {
            debugPrint('$date');
          },
          scaffoldKey: widget.scaffoldKey,
          person: widget.person,
        ));
      } else if (item.name == 'Messages') {
        _list.add(
          Messages(
            background: AppTheme.colorBox('meeting_color_four'),
            title: Languages.of(context).meetingMessageTitle,
            titleStyle: Theme.of(context).textTheme.headline2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 30, fontWeight: FontWeight.w700),
            subTitle: LanguageState.language == Language.en ? 'No ${Languages.of(context).meetingMessageSubText}' : '${Languages.of(context).meetingMessageSubText} موجود نیست ',
            subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 12, fontWeight: FontWeight.w400),
          ),
        );
      } else if (item.name == 'Notes') {
        _list.add(
          Notes(
            title: Languages.of(context).meetingNotesTitle,
            titleStyle: Theme.of(context).textTheme.headline2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 30, fontWeight: FontWeight.w700),
            subTitle: Languages.of(context).meetingNotesSubText,
            subTitleStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 12, fontWeight: FontWeight.w400),
            addNewNote: Languages.of(context).meetingNotesAddNew,
            addNewNoteStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontSize: 14, fontWeight: FontWeight.w500),
            background: AppTheme.colorBox('meeting_color_four'),
          ),
        );
      } else if (item.name == 'Meetings') {
        _list.add(
          Meetings(
            titleStyle: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one')),
            title: Languages.of(context).meetingsTitle,
          ),
        );
      }
    }
  }

  updateSequenceList() async {
    _sequenceItems = [];
    for (int index = 0; index < _list.length; index++) {
      if (_list[index] is InvitationMeetings) {
        _sequenceItems.add(SequenceItems(name: 'InvitationMeetings', id: '$index'));
      } else if (_list[index] is MultiMiniMeetingWidget) {
        _sequenceItems.add(SequenceItems(name: 'MultiMiniMeetingWidget', id: '$index'));
      } else if (_list[index] is MultiMiniPeopleGroupWidget) {
        _sequenceItems.add(SequenceItems(name: 'MultiMiniPeopleGroupWidget', id: '$index'));
      } else if (_list[index] is MultiMiniAssetsLocationWidget) {
        _sequenceItems.add(SequenceItems(name: 'MultiMiniAssetsLocationWidget', id: '$index'));
      } else if (_list[index] is MinCalendar) {
        _sequenceItems.add(SequenceItems(name: 'MinCalender', id: '$index'));
      } else if (_list[index] is Messages) {
        _sequenceItems.add(SequenceItems(name: 'Messages', id: '$index'));
      } else if (_list[index] is Notes) {
        _sequenceItems.add(SequenceItems(name: 'Notes', id: '$index'));
      } else if (_list[index] is Meetings) {
        _sequenceItems.add(SequenceItems(name: 'Meetings', id: '$index'));
      }
      await LocalStorage.instance.saveString({"sequence_items": json.encode(_sequenceItems)}, session: false);
    }
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('message: $message');
        NotificationDataModel notificationDataModel = NotificationDataModel(title:message.notification!.title ?? 'is empty',subTitle: message.notification!.body ?? 'is empty',status: false);
        context.read<NotificationBloc>().add(AddNotificationEvent(notificationDataModel));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('when onMessage: $message');

      NotificationDataModel notificationDataModel = NotificationDataModel(title:message.notification!.title ?? 'is empty',subTitle: message.notification!.body ?? 'is empty',status: false);
      context.read<NotificationBloc>().add(AddNotificationEvent(notificationDataModel));

      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null && !kIsWeb) {
      //   // flutterLocalNotificationsPlugin.show(
      //   //   notification.hashCode,
      //   //   notification.title,
      //   //   notification.body,
      //   //   NotificationDetails(
      //   //     android: AndroidNotificationDetails(
      //   //       channel.id,
      //   //       channel.name,
      //   //       channel.description,
      //   //       // TODO add a proper drawable resource to android, for now using
      //   //       //      one that already exists in example app.
      //   //       icon: 'launch_background',
      //   //     ),
      //   //   ),
      //   // );
      // }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      debugPrint('when onMessageOpenedApp : $message');
      NotificationDataModel notificationDataModel = NotificationDataModel(title:message.notification!.title ?? 'is empty',subTitle: message.notification!.body ?? 'is empty',status: false);
      context.read<NotificationBloc>().add(AddNotificationEvent(notificationDataModel));
    });
    loadSequence().then((value) {
      setState(() {});
    });
    context.read<LanguageBloc>().add(LoadLanguageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadWidget();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MeetingBloc(context.read<MeetingApiRepository>())),
        BlocProvider(create: (context) => MeetingPendingBloc(context.read<MeetingApiRepository>())),
        BlocProvider(create: (context) => MeetingDailyBloc(context.read<MeetingApiRepository>())),
        BlocProvider(create: (context) => MeetingHourlyBloc(context.read<MeetingApiRepository>())),

      ],
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          if (constraints.maxWidth <= 1110) {
            _width = constraints.maxWidth / 2;
            _childAspectRatio = 1;
          } else {
            _width = constraints.maxWidth / 3;
            _childAspectRatio = constraints.maxWidth / (constraints.maxHeight * 1.5);
          }
        } else if (constraints.maxWidth == constraints.maxHeight) {
          _width = constraints.maxWidth / 2;
          _childAspectRatio = 1;
        } else {
          if (constraints.maxWidth < 740) {
            _width = constraints.maxWidth;
            _childAspectRatio = 1;
          } else {
            _width = constraints.maxWidth / 2;
            _childAspectRatio = 1;
          }
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
                  border: Border.all(width: 1, color: AppTheme.colorBox('meetings_color_one') ?? Colors.black),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const SizedBox(
                      width: 16.0,
                    ),
                    IconButton(
                      tooltip: Languages.of(context).meetingLogOutButton,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, Routes.SignInScreen, (route) => false);
                      },
                      icon: const Icon(FeatherIcons.logOut),
                      iconSize: 32,
                      color: AppTheme.colorBox('meeting_color_four') ?? Colors.black,
                    ),
                    const Spacer(),
                    NotificationWidget(
                      scaffoldKey: widget.scaffoldKey,
                    ),
                    IconButton(
                      tooltip: Languages.of(context).settings,
                      onPressed: () {},
                      icon: const Icon(FeatherIcons.settings),
                      iconSize: 32,
                      color: AppTheme.colorBox('meeting_color_four') ?? Colors.black,
                    ),
                    IconButton(
                      tooltip: Languages.of(context).language,
                      onPressed: () {
                        if (LanguageState.language == Language.en) {
                          context.read<LanguageBloc>().add((ChangeLanguageEvent(Language.fa)));
                        } else {
                          context.read<LanguageBloc>().add((ChangeLanguageEvent(Language.en)));
                        }
                      },
                      icon: const Icon(FeatherIcons.globe),
                      iconSize: 32,
                      color: AppTheme.colorBox('meeting_color_four') ?? Colors.black,
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ReorderableWrap(
                  controller: ScrollController(),
                  needsLongPressDraggable: false,
                  spacing: 0,
                  runSpacing: 0,
                  children: _list
                      .map((element) => SizedBox(
                            width: _width,
                            height: _width! / _childAspectRatio!,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: element,
                            ),
                          ))
                      .toList(),
                  onReorder: (int oldIndex, int newIndex) {
                    setState(() {
                      Widget row = _list.removeAt(oldIndex);
                      _list.insert(newIndex, row);
                      updateSequenceList();
                    });
                  },
                  onNoReorder: (int index) {
                    // debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                  },
                  onReorderStarted: (int index) {
                    // debugPrint('${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                  }),
            ),
          ],
        );
      }),
    );
  }
}
