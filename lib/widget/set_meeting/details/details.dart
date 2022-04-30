import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/member/model/member.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/calendar/clock.dart';
import 'package:meeting_management/widget/set_meeting/widget/priority_widget.dart';
import 'package:reorderables/reorderables.dart';
import 'package:shamsi_date/shamsi_date.dart';

class Details extends StatefulWidget {
  const Details({
    Key? key,
    required this.dateTime,
    required this.location,
    required this.members, required this.titleController, required this.descriptionController, required this.priorityStatus,
  }) : super(key: key);
  final DateTime dateTime;
  final LocationModel location;
  final List<Member> members;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final Function(PriorityStatus) priorityStatus;
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
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
                SizedBox(
                  width: constraints.maxWidth * 0.03,
                ),
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
                SizedBox(
                  width: constraints.maxWidth * 0.01,
                ),
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
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  FeatherIcons.users,
                  size: 24,
                  color: AppTheme.colorBox('meeting_color_ten'),
                ),
                SizedBox(
                  width: constraints.maxWidth * 0.01,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: ReorderableWrap(
                        controller: ScrollController(),
                        needsLongPressDraggable: false,
                        spacing: 8,
                        runSpacing: 4,
                        onReorder: (int oldIndex, int newIndex) {},
                        children: widget.members.map((element) {
                          return Text(
                            '${element.firstName} ${element.lastName}',
                            style: Theme.of(context).textTheme.headline6!.copyWith(
                                color: element.type == 3 ? AppTheme.colorBox('meeting_color_eight') : AppTheme.colorBox('meeting_color_four'),
                                fontWeight: FontWeight.w600,
                                backgroundColor: element.type == 3 ? AppTheme.colorBox('meeting_color_four') : AppTheme.colorBox('meeting_color_seven')),
                          );
                        }).toList()),
                  ),
                ),
                PriorityWidget(change: (value){
                  widget.priorityStatus(value);
                },),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1, color: Colors.black),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Center(
                      child: Text(
                        '${Languages.of(context).title}:',
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                      ),
                    ),
                    SizedBox(
                      width: constraints.maxWidth * 0.01,
                    ),
                    Center(
                      child: SizedBox(
                        width: constraints.maxWidth * 0.25,
                        child: TextField(
                          decoration:  const InputDecoration(
                            border: InputBorder.none,
                            // hintText: Languages.of(context).title.toLowerCase(),
                          ),
                          showCursor: true,
                          textDirection: LanguageState.language == Language.en ? TextDirection.ltr : TextDirection.rtl,
                          controller: widget.titleController,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
                          onChanged: (value){
                            widget.titleController.text = widget.titleController.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                            widget.titleController.selection = TextSelection.fromPosition(TextPosition(offset: widget.titleController.text.length));
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(width: 1, color: Colors.black),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${Languages.of(context).description}:',
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline5!
                          .copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          // hintText: Languages.of(context).description.toLowerCase(),
                        ),
                        textDirection: LanguageState.language == Language.en ? TextDirection.ltr : TextDirection.rtl,
                        controller: widget.descriptionController,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
                        maxLines: 200,
                        showCursor: true,
                        onChanged: (value){
                          widget.descriptionController.text = widget.descriptionController.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                          widget.descriptionController.selection = TextSelection.fromPosition(TextPosition(offset: widget.descriptionController.text.length));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: constraints.maxWidth * 0.3,
              height: 30,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Icon(
                        FeatherIcons.upload,
                        size: 24,
                        color: AppTheme.colorBox('meeting_color_eight'),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          Languages.of(context).meetingAddFiles,
                          style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w500),
                        )),
                  ],
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meetings_color_three')),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
