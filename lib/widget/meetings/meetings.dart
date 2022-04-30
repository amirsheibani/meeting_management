import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/logic/meeting/model/meeting_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/meetings/widget/meetings_item.dart';
import 'bloc/meeting_bloc.dart';

class Meetings extends StatefulWidget {
  const Meetings({Key? key, this.titleStyle, this.title}) : super(key: key);
  final TextStyle? titleStyle;
  final String? title;

  @override
  _MeetingsState createState() => _MeetingsState();
}

class _MeetingsState extends State<Meetings> {
  List<MeetingModel> _meetingList = [];
  late DateTime _dateTime;
  @override
  void initState() {
    _dateTime = DateTime.now();
    context.read<MeetingBloc>().add(RetrieveMeetingEvent(_dateTime,_dateTime));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 50,
          child: Text(
            widget.title ?? 'Meetings',
            style: widget.titleStyle ?? const TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Color(0xFF000000)),
          ),
        ),
        Expanded(
          child: BlocConsumer<MeetingBloc, MeetingState>(
            listener: (context, state) {
              if (state is MeetingError) {
                debugPrint('Meeting list Ex:${state.props[0]}');
              }
            },
            builder: (context, state) {
              if (state is MeetingRetrieve) {
                _meetingList = state.props[0];
              }
              if(_meetingList.isNotEmpty){
                return ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: ListView.separated(
                    controller: ScrollController(),
                    itemBuilder: (BuildContext context, int index) {
                      return
                        MeetingsItem(
                          switchActiveColor: AppTheme.colorBox('meeting_color_thirteen'),
                          titleStyle: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w500,
                            decoration: _meetingList[index].status == 4 ? TextDecoration.lineThrough : null,
                            decorationColor: AppTheme.colorBox('meeting_color_ten'),
                            color: AppTheme.colorBox('meeting_color_eight'),
                          ),
                          canceledTextStyle: Theme.of(context).textTheme.subtitle1!.copyWith(fontWeight: FontWeight.w400, color: AppTheme.colorBox('meeting_color_ten')),
                          textStyle: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontWeight: FontWeight.w400,
                            color: AppTheme.colorBox('meeting_color_eight'),
                          ),
                          iconColor: AppTheme.colorBox('meeting_color_eight'),
                          backgroundColor: AppTheme.colorBox('meetings_color_three'),
                          meetingModel: _meetingList[index],
                        );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 5.0,
                      );
                    },
                    itemCount: _meetingList.length,
                  ),
                );
              }
              return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'), strokeWidth: 1.5));
            },
          ),
        ),
      ],
    );
  }
}
