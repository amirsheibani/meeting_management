import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class InvitationMeetingStatus extends StatefulWidget {
  const InvitationMeetingStatus({
    Key? key,
    required this.onChange,
    this.statusTitle1,
    this.statusTitle2,
    this.statusTitle3, this.textStyle,
    this.iconColor,
  }) : super(key: key);
  final Function(MeetingInvitationType value) onChange;
  final String? statusTitle1;
  final String? statusTitle2;
  final String? statusTitle3;
  final TextStyle? textStyle;
  final Color? iconColor;

  @override
  _InvitationMeetingStatusState createState() => _InvitationMeetingStatusState();
}

class _InvitationMeetingStatusState extends State<InvitationMeetingStatus> {
  MeetingInvitationType meetingInvitationType = MeetingInvitationType.idle;
  final TextStyle defaultTextStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.red,);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: Icon(
              meetingInvitationType == MeetingInvitationType.accept ? FeatherIcons.checkSquare : FeatherIcons.square,
              color:widget.iconColor?? Colors.blueGrey,
              size: 24,
            ),
            title: Text(
              widget.statusTitle1 ?? '',
              style:widget.textStyle ?? defaultTextStyle,
            ),
            onTap: () {
              setState(() {
                meetingInvitationType = MeetingInvitationType.accept;
                widget.onChange(meetingInvitationType);
              });
            },
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: Icon(
              meetingInvitationType == MeetingInvitationType.deny ? FeatherIcons.checkSquare : FeatherIcons.square,
              color:widget.iconColor?? Colors.blueGrey,
              size: 24,
            ),
            title: Text(
              widget.statusTitle2 ?? '',
              style:widget.textStyle?? defaultTextStyle,
            ),
            onTap: () {
              setState(() {
                meetingInvitationType = MeetingInvitationType.deny;
                widget.onChange(meetingInvitationType);
              });
            },
          ),
        ),
        Expanded(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: 0,
            leading: Icon(
              meetingInvitationType == MeetingInvitationType.delayed ? FeatherIcons.checkSquare : FeatherIcons.square,
              color:widget.iconColor?? Colors.blueGrey,
              size: 24,
            ),
            title: Text(
              widget.statusTitle3 ?? '',
              style:widget.textStyle?? defaultTextStyle,
            ),
            onTap: () {
              setState(
                () {
                  meetingInvitationType = MeetingInvitationType.delayed;
                  widget.onChange(meetingInvitationType);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

enum MeetingInvitationType { idle, accept, deny, delayed }
