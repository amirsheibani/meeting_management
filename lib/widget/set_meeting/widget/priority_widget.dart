import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';

class PriorityWidget extends StatefulWidget {
  const PriorityWidget({Key? key, required this.change}) : super(key: key);
  final Function(PriorityStatus) change;

  @override
  _PriorityWidgetState createState() => _PriorityWidgetState();
}

class _PriorityWidgetState extends State<PriorityWidget> {
  PriorityStatus _priorityStatus = PriorityStatus.none;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(Languages.of(context).low,style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_seven'), fontWeight: FontWeight.w400),),
        InkWell(
          child: Icon(_priorityStatus == PriorityStatus.low ? FeatherIcons.checkCircle : FeatherIcons.circle,color: AppTheme.colorBox('meeting_color_seven'),size: 24,),
          onTap: (){
            setState(() {
              _priorityStatus = PriorityStatus.low;
              widget.change(_priorityStatus);
            });
          },
        ),
        const SizedBox(width: 8.0),
        Text(Languages.of(context).medium,style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),),
        InkWell(
          child: Icon(_priorityStatus == PriorityStatus.medium ? FeatherIcons.checkCircle : FeatherIcons.circle,color: AppTheme.colorBox('meeting_color_four'),size: 24,),
          onTap: (){
            setState(() {
              _priorityStatus = PriorityStatus.medium;
              widget.change(_priorityStatus);
            });
          },
        ),
        const SizedBox(width: 8.0),
        Text(Languages.of(context).high,style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_ten'), fontWeight: FontWeight.w400),),
        InkWell(
          child: Icon(_priorityStatus == PriorityStatus.high ? FeatherIcons.checkCircle : FeatherIcons.circle,color: AppTheme.colorBox('meeting_color_ten'),size: 24,),
          onTap: (){
            setState(() {
              _priorityStatus = PriorityStatus.high;
              widget.change(_priorityStatus);
            });
          },
        )
      ],
    );
  }
}
enum PriorityStatus{
  none,low,medium,high
}