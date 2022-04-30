import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/invitation_meeting/bloc/pending_invitees_bloc/pending_invitees_bloc.dart';
import 'package:meeting_management/widget/invitation_meeting/invitation_meeting_status.dart';

class InvitationMeetingDetails extends StatefulWidget {
  const InvitationMeetingDetails({
    Key? key,
    this.height,
    this.boxBackgroundColor,
    this.headerHeight,
    this.headerColor,
    // this.headerTitle,
    this.headerStyle,
    this.date,
    this.time,
    this.projectName,
    this.meetingRoomName,
    this.users,
    this.textStyle,
    required this.downloadOnTap,
    required this.width,
    this.headerIconColor,
    this.bodyIconColor,
    required this.meetingId,
  }) : super(key: key);
  final double? height;
  final double? headerHeight;
  final Color? boxBackgroundColor;
  final Color? headerColor;

  // final String? headerTitle;
  final TextStyle? headerStyle;
  final TextStyle? textStyle;
  final String? date;
  final String? time;
  final String? projectName;
  final String? meetingRoomName;
  final List<String>? users;
  final Function downloadOnTap;
  final double width;
  final Color? headerIconColor;
  final Color? bodyIconColor;
  final int meetingId;

  @override
  _InvitationMeetingDetailsState createState() => _InvitationMeetingDetailsState();
}

class _InvitationMeetingDetailsState extends State<InvitationMeetingDetails> {
  String usersName = '';
  List<String> users = [];
  MeetingInvitationType? _meetingInvitationType;
  final TextStyle _defaultTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PendingInviteesBloc(context.read<MeetingApiRepository>())..add(InviteesPendingMeetingEvent(widget.meetingId)),
      child: Container(
        width: widget.width,
        height: widget.height ?? 254,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.boxBackgroundColor ?? const Color(0xFFF0F1F3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.headerHeight ?? 48,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                color: widget.headerColor ?? const Color(0xFF030F34),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    Languages.of(context).meetingDetailTitle,
                    style: widget.headerStyle ?? const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.red),
                  ),
                  const Spacer(
                    flex: 6,
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(bottom: 2),
                    icon: Icon(
                      FeatherIcons.xCircle,
                      size: 36,
                      color: widget.headerIconColor ?? Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(_meetingInvitationType);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            title: Text(
                              widget.date != null ? widget.date!.convertNumberWithLanguage() : '01/09/2040'.convertNumberWithLanguage(),
                              style: widget.textStyle ?? _defaultTextStyle,
                            ),
                            leading: Icon(
                              FeatherIcons.calendar,
                              color: widget.bodyIconColor ?? const Color(0xFF030F34),
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            title: Text(
                              widget.time != null ? widget.time!.convertNumberWithLanguage() : '00:00:00'.convertNumberWithLanguage(),
                              style: widget.textStyle ?? _defaultTextStyle,
                            ),
                            leading: SizedBox(
                              width: 16,
                              height: 16,
                              child: MinClock(
                                dateTime: DateFormat("hh:mm").parse('${widget.time}'),
                                strokeWidth: 1.2,
                                strokeWidthCircle: 2,
                                color: widget.bodyIconColor ?? const Color(0xFF030F34),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            title: Text(
                              widget.projectName ?? 'default value',
                              style: widget.textStyle ?? _defaultTextStyle,
                            ),
                            leading: Icon(
                              FeatherIcons.clipboard,
                              color: widget.bodyIconColor ?? Color(0xFF030F34),
                              size: 24,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: ListTile(
                            horizontalTitleGap: 0,
                            title: Text(
                              widget.meetingRoomName ?? 'default value',
                              style: widget.textStyle ?? _defaultTextStyle,
                            ),
                            leading: Icon(
                              FeatherIcons.mapPin,
                              color: widget.bodyIconColor ?? const Color(0xFF030F34),
                              size: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer<PendingInviteesBloc, PendingInviteesState>(
                      listener: (context, state) {
                        if (state is PendingInviteesError) {
                          debugPrint('PendingInviteesError Ex:${state.props[0]}');
                        }
                      },
                      builder: (context, state) {
                        if (state is PendingInviteesRetrieve) {
                          List<InviteesModel> _items =[];
                          for (var element in state.props[0]) {
                            if(_items.where((e) => (e.member!.firstName == element.member!.firstName!) && (e.member!.lastName == element.member!.lastName!)).isEmpty){
                              _items.add(element);
                              users.add('${element.member!.firstName!} ${element.member!.lastName!}');
                            }
                          }
                        }
                        StringBuffer stringBuffer = StringBuffer();
                        for (var user in users) {
                          stringBuffer.write(user + ', ');
                        }
                        usersName = stringBuffer.toString();
                        return ListTile(
                          horizontalTitleGap: 0,
                          title: Text(
                            usersName,
                            style: widget.textStyle ?? _defaultTextStyle,
                          ),
                          leading: Icon(
                            users.length == 1 ? FeatherIcons.user : FeatherIcons.users,
                            color: widget.bodyIconColor ?? const Color(0xFF030F34),
                            size: 24,
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: Icon(
                        FeatherIcons.edit3,
                        color: widget.bodyIconColor ?? const Color(0xFF030F34),
                        size: 24,
                      ),
                      title: InvitationMeetingStatus(
                        iconColor: AppTheme.colorBox('meeting_color_four'),
                        statusTitle1: Languages.of(context).meetingAcceptInvitation,
                        statusTitle2: Languages.of(context).meetingDenyInvitation,
                        statusTitle3: Languages.of(context).meetingDelayedInvitation,
                        onChange: (MeetingInvitationType value) {
                          _meetingInvitationType = value;
                        },
                        textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w400, color: AppTheme.colorBox('meeting_color_four')),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      horizontalTitleGap: 0,
                      title: Text(
                        Languages.of(context).meetingAgendaDownload,
                        style: widget.textStyle ?? _defaultTextStyle,
                      ),
                      leading: Icon(
                        FeatherIcons.download,
                        color: widget.bodyIconColor ?? const Color(0xFF030F34),
                        size: 24,
                      ),
                      onTap: () {
                        widget.downloadOnTap();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
