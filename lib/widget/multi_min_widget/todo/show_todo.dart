import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/model/todo_model.dart';
import 'package:shamsi_date/shamsi_date.dart';

class NewTodoWidget extends StatefulWidget {
  const NewTodoWidget({Key? key, this.todoModel}) : super(key: key);
  final TodoModel? todoModel;
  @override
  _NewTodoWidgetState createState() => _NewTodoWidgetState();
}

class _NewTodoWidgetState extends State<NewTodoWidget> {
  late final DateTime _dateTime;
  Gregorian? _gregorianDate;
  Jalali? _jalaliDate;
  String? _date;
  TextEditingController? _titleController;
  TextEditingController? _descriptionController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    if (widget.todoModel != null) {
      _dateTime = DateTime.parse(widget.todoModel!.creationDate!);
      _descriptionController!.text = widget.todoModel!.description!.convertNumberWithLanguage().changeCharacterWithLanguage();
      _titleController!.text = widget.todoModel!.title!.convertNumberWithLanguage().changeCharacterWithLanguage();
    } else {
      _dateTime = DateTime.now();
    }

    if (LanguageState.language == Language.en) {
      _gregorianDate = _dateTime.toGregorian();
      _date = '${_gregorianDate!.year}-${_gregorianDate!.month < 10 ? '0${_gregorianDate!.month}' : '${_gregorianDate!.month}'}-${_gregorianDate!.day < 10 ? '0${_gregorianDate!.day}' : '${_gregorianDate!.day}'}';
    } else {
      _jalaliDate = _dateTime.toJalali();
      _date = '${_jalaliDate!.year}-${_jalaliDate!.month < 10 ? '0${_jalaliDate!.month}' : '${_jalaliDate!.month}'}-${_jalaliDate!.day < 10 ? '0${_jalaliDate!.day}' : '${_jalaliDate!.day}'}';
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
          color: AppTheme.colorBox('meeting_color_eight'),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: constraints.maxWidth * 0.05, left: constraints.maxWidth * 0.05),
          child: Column(
            children: [
              const SizedBox(height: 8.0),
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
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              hintText: Languages.of(context).title.toLowerCase(),
                            ),
                            controller: _titleController!,
                            style: Theme
                                .of(context)
                                .textTheme
                                .headline5!
                                .copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
                            onChanged: (value){
                              _titleController!.text = _titleController!.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                              _titleController!.selection = TextSelection.fromPosition(TextPosition(offset: _titleController!.text.length));
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.02,
                      ),
                      Center(
                        child: Icon(
                          FeatherIcons.calendar,
                          size: 24,
                          color: AppTheme.colorBox('meeting_color_four'),
                        ),
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.01,
                      ),
                      Center(
                        child: Text(
                          _date!.convertNumberWithLanguage(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
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
                        '${Languages.of(context).title}:',
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
                          decoration:  InputDecoration(
                            border: InputBorder.none,
                            hintText: Languages.of(context).description.toLowerCase(),
                          ),
                          controller: _descriptionController,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5!
                              .copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
                          maxLines: 200,
                          onChanged: (value){
                            _descriptionController!.text = _descriptionController!.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                            _descriptionController!.selection = TextSelection.fromPosition(TextPosition(offset: _descriptionController!.text.length));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                          TodoModel _todoModel = TodoModel();
                          if(widget.todoModel != null){
                            _todoModel = widget.todoModel!;
                            _todoModel.title = _titleController!.text;
                            _todoModel.description = _descriptionController!.text;
                            _todoModel.creationDate = DateTime.now().toString();
                          }else{
                            _todoModel.title = _titleController!.text;
                            _todoModel.description = _descriptionController!.text;
                            _todoModel.creationDate = DateTime.now().toString();
                          }
                          Navigator.of(context).pop([_todoModel]);
                        },
                        child: Text(
                            widget.todoModel != null ? Languages.of(context).meetingButtonUpdate : Languages.of(context).meetingButtonSave,
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
                          Navigator.of(context).pop();
                        },
                        child: Text(Languages
                            .of(context)
                            .meetingButtonCancel, style: Theme
                            .of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),),
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
                  ],
                ),),
            ],
          ),
        ),
      );
    });
  }
}
