import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:intl/intl.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/meeting/model/Invitees_model.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/bloc/calendar_bloc.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/meetings/bloc/meeting_bloc.dart';
import 'package:meeting_management/widget/meetings/widget/bloc/invitees_bloc/invitees_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/location/bloc/location_bloc.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shamsi_date/shamsi_date.dart';

class EditMeetingWidget extends StatefulWidget {
  const EditMeetingWidget({Key? key, required this.scaffoldKey, required this.person, required this.meetingModel, required this.dateTime}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Person person;
  final MeetingModel meetingModel;
  final DateTime dateTime;

  @override
  State<EditMeetingWidget> createState() => _EditMeetingWidgetState();
}

class _EditMeetingWidgetState extends State<EditMeetingWidget> {
  List<InviteesModel> _inviteesModelList = [];
  List<LocationModel> _locations = [];
  List<AssetModel> _assets = [];
  @override
  void initState() {
    context.read<LocationBloc>().add(RetrieveLocationEvent(id: widget.meetingModel.locationId));
    context.read<InviteesBloc>().add(InviteesMeetingEvent(widget.meetingModel.id!));
    context.read<AssetBloc>().add(RetrieveAssetMeetingEvent(id:widget.meetingModel.id!));


    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<LocationBloc, LocationState>(
          listener: (context, state) {
            if(state is LocationErrorState){
              debugPrint('location event Ex:${state.props[0]}');
            }else if(state is RetrieveLocationLoadedState){
              setState(() {
                _locations = state.props[0] as List<LocationModel>;
              });
            }
          },
        ),
        BlocListener<InviteesBloc, InviteesState>(
          listener: (context, state) {
            if(state is InviteesError){
              debugPrint('Invitees event Ex:${state.props[0]}');
            }else if(state is InviteesRetrieve){
              setState(() {
                _inviteesModelList = state.props[0];
              });
            }
          },
        ),
        BlocListener<AssetBloc, AssetState>(
            listener: (context, state) {
          if(state is AssetErrorState){
            debugPrint('asset event Ex:${state.props[0]}');
          }else if(state is RetrieveAssetLoadedState){
            setState(() {
              _assets.add(state.assets.last);
            });
          }else if(state is RetrieveAssetMeetingLoadedState){
            for (var element in state.assets) {
              context.read<AssetBloc>().add(RetrieveAssetEvent(id:element));
            }
          }
        }),
        BlocListener<CalendarBloc, CalendarState>(
            listener: (context, state) {
          if(state is CalendarError){
            debugPrint('CalendarError Ex:${state.props[0]}');
          }else if(state is CalendarRemoveMeeting){
            Navigator.of(context).pop();
          }
        })
      ],
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        child: Row(
          children: [
            const Spacer(),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.calendar, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).date}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                            LanguageState.language == Language.fa
                                ? Jalali.fromDateTime(DateTime.parse(widget.meetingModel.startDate!)).jalaliDateFormat().convertNumberWithLanguage()
                                : Gregorian.fromDateTime(DateTime.parse(widget.meetingModel.startDate!)).gregorianDateFormat(),
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: MinClock(
                          dateTime: DateTime.parse(widget.meetingModel.startDate!),
                          strokeWidth: 1.2,
                          strokeWidthCircle: 2,
                          color: AppTheme.colorBox('meeting_color_nineteen'),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).time}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                            LanguageState.language == Language.fa
                                ? Jalali.fromDateTime(DateTime.parse(widget.meetingModel.startDate!)).jalaliTimeFormat().convertNumberWithLanguage()
                                : Gregorian.fromDateTime(DateTime.parse(widget.meetingModel.startDate!)).gregorianTimeFormat(),
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.mapPin, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).location}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text('${_locations.isNotEmpty ? _locations.last.name : ''}', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.users, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).members}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      ReorderableWrap(
                          controller: ScrollController(),
                          needsLongPressDraggable: false,
                          spacing: 8,
                          runSpacing: 4,
                          onReorder: (int oldIndex, int newIndex) {},
                          children: _inviteesModelList.map((element) {
                            return Container(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                '${element.member!.firstName} ${element.member!.lastName}',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: element.member!.type == 3 ? AppTheme.colorBox('meeting_color_four') : AppTheme.colorBox('meeting_color_seven')),
                              ),
                            );
                          }).toList()),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.plusCircle, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).subject}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                            widget.meetingModel.title!,
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.box, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).assets}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                      ReorderableWrap(
                          controller: ScrollController(),
                          needsLongPressDraggable: false,
                          spacing: 8,
                          runSpacing: 4,
                          onReorder: (int oldIndex, int newIndex) {},
                          children: _assets.map((element) {
                            return Container(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0, left: 16.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppTheme.colorBox('meeting_color_four'), width: 1.0),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                '${element.name}',
                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                    color: AppTheme.colorBox('meeting_color_four') ),
                              ),
                            );
                          }).toList()),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(FeatherIcons.edit, size: 24, color: AppTheme.colorBox('meeting_color_four')),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Text('${Languages.of(context).agenda}:', style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w600)),
                      const SizedBox(
                        width: 16.0,
                      ),
                      const Spacer(),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 80.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 34,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                Languages.of(context).meetingButtonOk,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline6!
                                    .copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300)),
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
                        const SizedBox(
                          width: 8.0,
                        ),
                        SizedBox(
                          width: 90,
                          height: 34,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<CalendarBloc>().add(CalendarMeetingRemoveEvent(widget.meetingModel.id!));
                            },
                            child: Text(
                              Languages.of(context).meetingButtonRemove,
                              style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              alignment: Alignment.center,
                              backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_ten')),
                            ),
                          ),
                        ),
                      ],
                    ),),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
