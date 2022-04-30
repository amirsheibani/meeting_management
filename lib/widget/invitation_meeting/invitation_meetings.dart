import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/bloc/calendar_bloc.dart';
import 'package:meeting_management/widget/calendar/calendar_screen.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/invitation_meeting/invitation_meeting_item.dart';
import 'package:meeting_management/widget/meetings/bloc/meeting_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/meeting_mini_hourly/bloc/meeting_hourly_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/metting_mini_daily/bloc/meeting_daily_bloc.dart';

import 'bloc/pending_bloc/meeting_pending_bloc.dart';

class InvitationMeetings extends StatefulWidget {
  const InvitationMeetings({Key? key, required this.meetingButtonOnTap, this.textStyle, this.title, required this.scaffoldKey, required this.person}) : super(key: key);
  final Function meetingButtonOnTap;
  final TextStyle? textStyle;
  final String? title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Person person;

  @override
  _InvitationMeetingsState createState() => _InvitationMeetingsState();
}

class _InvitationMeetingsState extends State<InvitationMeetings> {
  List<MeetingModel> _items = [];

  @override
  void initState() {
    super.initState();
    context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Text(
            widget.title ?? 'Invitation Meetings',
            style: widget.textStyle ?? const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.red),
          ),
        ),
        Expanded(
          child: BlocConsumer<MeetingPendingBloc, MeetingPendingState>(
            listener: (context, state) {
              if(state is PendingMeetingError){
                debugPrint('pending meeting Ex:${state.props[0]}');
              }else if(state is UpdatePendingMeeting){
                context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
              }
            },
            builder: (context, state) {
              if(state is PendingRetrieve){
                _items = state.props[0];
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    return InvitationMeetingItem(
                      checkSquareIconColor: AppTheme.colorBox('meeting_color_twelve'),
                      dialogBackground: AppTheme.colorBox('meeting_color_fourteen'),
                      buttonBackground: AppTheme.colorBox('meetings_color_three'),
                      textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight')),
                      meetingModel: _items[index],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10.0,
                    );
                  },
                  itemCount: _items.length,
                );
              }
              return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_four'), strokeWidth: 1.5));
            },
          ),
        ),
        SizedBox(
          width: double.maxFinite,
          height: 46,
          child: ElevatedButton(
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
                context.read<MeetingBloc>().add(RetrieveMeetingEvent(DateTime.now(), DateTime.now()));
                context.read<MeetingPendingBloc>().add(const PendingMeetingEvent());
                context.read<MeetingDailyBloc>().add(RetrieveMeetingDailyEvent(fromDate: DateTime.now(),toDate: DateTime.now()));
                context.read<MeetingHourlyBloc>().add(RetrieveMeetingHourlyEvent(fromDate: DateTime.now(),toDate: DateTime.now()));
                if (value != null) {}
              });
            },
            child: Text(
              Languages.of(context).setMeeting,
              style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight')),
            ),
          ),
        ),
      ],
    );
  }
}
