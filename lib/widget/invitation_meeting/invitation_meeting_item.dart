import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/invitation_meeting/invitation_meeting_details.dart';
import 'package:meeting_management/widget/invitation_meeting/invitation_meeting_status.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'bloc/pending_bloc/meeting_pending_bloc.dart';
import 'bloc/pending_location_bloc/pending_location_bloc.dart';

class InvitationMeetingItem extends StatefulWidget {
  const InvitationMeetingItem({
    Key? key,
    this.textStyle,
    this.buttonBackground,
    this.height,
    this.checkSquareIconColor,
    this.dialogBackground,
    required this.meetingModel,
  }) : super(key: key);

  final TextStyle? textStyle;
  final Color? buttonBackground;
  final double? height;
  final Color? checkSquareIconColor;
  final Color? dialogBackground;
  final MeetingModel meetingModel;

  @override
  _InvitationMeetingItemState createState() => _InvitationMeetingItemState();
}

class _InvitationMeetingItemState extends State<InvitationMeetingItem> {
  MeetingInvitationType? _meetingInvitationType;
  String _date = '';
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;
  String _time = '';
  Gregorian? _gregorianTime;
  Jalali? _jalaliTime;

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    DateTime dateTime = DateTime.parse(widget.meetingModel.startDate!);
    if (LanguageState.language == Language.en) {
      _gregorianDate = dateTime.toGregorian();
      _date = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
    } else {
      _jalaliDate = dateTime.toJalali();
      _date = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
    }
    if (LanguageState.language == Language.en) {
      _gregorianTime = dateTime.toGregorian();
      _time =
          '${_gregorianTime!.hour < 10 ? '0${_gregorianTime!.hour.convertHalfFormatHour()}' : '${_gregorianTime!.hour.convertHalfFormatHour()}'}:${_gregorianTime!.minute < 10 ? '0${_gregorianTime!.minute}' : '${_gregorianTime!.minute}'}';
    } else {
      _jalaliTime = dateTime.toJalali();
      _time = '${_jalaliTime!.hour < 10 ? '0${_jalaliTime!.hour.convertHalfFormatHour()}' : '${_jalaliTime!.hour.convertHalfFormatHour()}'}:${_jalaliTime!.minute < 10 ? '0${_jalaliTime!.minute}' : '${_jalaliTime!.minute}'}';
    }
    return BlocProvider(
      create: (context) => PendingLocationBloc(context.read<LocationRepository>())..add(RetrieveLocationMeetingEvent(widget.meetingModel.locationId)),
      child: BlocConsumer<PendingLocationBloc, PendingLocationState>(
  listener: (context, state) {
    if(state is LocationMeetingError){
      debugPrint('LocationMeetingPendingError Ex:${state.props[0]}');
    }
  },
  builder: (context, state) {
    if(state is LocationMeetingRetrieve){
      String location = state.props[0].last.name!;
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: widget.height ?? 58,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                alignment: Alignment.center,
                backgroundColor: MaterialStateProperty.all<Color>(widget.buttonBackground ?? Colors.blue),
              ),
              onPressed: () {
                if (MediaQuery.of(context).size.width < 740) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        elevation: 0,
                        backgroundColor: widget.dialogBackground != null ? widget.dialogBackground!.withOpacity(0.4) : Colors.grey.shade900.withOpacity(0.4),
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return Material(
                              child: InvitationMeetingDetails(
                                headerIconColor: AppTheme.colorBox('meeting_color_eight'),
                                bodyIconColor: AppTheme.colorBox('meeting_color_four'),
                                boxBackgroundColor: AppTheme.colorBox('meeting_color_eight'),
                                textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.colorBox('meeting_color_four'),
                                ),
                                headerStyle: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.colorBox('meeting_color_eight'),
                                ),
                                headerColor: AppTheme.colorBox('meeting_color_four'),
                                downloadOnTap: () {},
                                width: constraints.maxWidth * 0.95,
                                height: constraints.maxHeight * 0.5,
                                meetingRoomName: location,
                                projectName: widget.meetingModel.title,
                                date: _date,
                                time: _time, meetingId: widget.meetingModel.id!,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    barrierColor: Colors.transparent,
                  ).then(
                        (value) {
                      if (value != null) {
                        setState(() {
                          _meetingInvitationType = value;
                        });
                      } else {
                        _meetingInvitationType = MeetingInvitationType.idle;
                      }
                    },
                  );
                } else {
                  showAlignedDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Material(
                        child: InvitationMeetingDetails(
                          headerIconColor: AppTheme.colorBox('meeting_color_eight'),
                          bodyIconColor: AppTheme.colorBox('meeting_color_four'),
                          boxBackgroundColor: AppTheme.colorBox('meeting_color_eight'),
                          headerColor: AppTheme.colorBox('meeting_color_four'),
                          textStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.colorBox('meeting_color_four'),
                          ),
                          headerStyle: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.colorBox('meeting_color_eight'),
                          ),
                          downloadOnTap: () {},
                          width: constraints.maxWidth,
                          meetingRoomName: location,
                          projectName: widget.meetingModel.title,
                          date: _date,
                          time: _time, meetingId: widget.meetingModel.id!,
                        ),
                      );
                    },
                    barrierDismissible: false,
                    isGlobal: false,
                    offset: const Offset(0, 100),
                    barrierColor: Colors.transparent,
                  ).then(
                        (value) {
                      if (value != null) {
                        MeetingModel _meetingModel = widget.meetingModel;
                        if(value == MeetingInvitationType.idle){

                        }else if(value == MeetingInvitationType.accept){

                        }else if(value == MeetingInvitationType.deny){

                        }else if(value == MeetingInvitationType.delayed){

                        }
                        context.read<MeetingPendingBloc>().add(UpdatePendingMeetingEvent(_meetingModel));
                      } else {
                        _meetingInvitationType = MeetingInvitationType.idle;
                      }
                    },
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: _meetingInvitationType == MeetingInvitationType.accept
                        ? Icon(
                      FeatherIcons.checkSquare,
                      color: widget.checkSquareIconColor ?? const Color(0xFF03FF86),
                      size: 15,
                    )
                        : null,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      Languages.of(context).meetingInvitationDescription,
                      style: widget.textStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                    ),
                  ),
                  Text(
                    _date.convertNumberWithLanguage(),
                    style: widget.textStyle ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
    return const SizedBox();
  },
),
    );
  }
}
