import 'package:behpardaz_flutter_custom_widget/behpardaz_flutter_custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';

class NewMessageWidget extends StatefulWidget {
  const NewMessageWidget({Key? key}) : super(key: key);

  @override
  _NewMessageWidgetState createState() => _NewMessageWidgetState();
}

class _NewMessageWidgetState extends State<NewMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          color: AppTheme.colorBox('meeting_color_eight'),
        ),
        child: Padding(
          padding: EdgeInsets.only(
              right: constraints.maxWidth * 0.05,
              left: constraints.maxWidth * 0.05),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Text(
                      Languages.of(context).meetingMessageTo,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.colorBox('meeting_color_four')),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Row(
                  children: [
                    Text(
                      Languages.of(context).meetingMessageSubject,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppTheme.colorBox('meeting_color_four')),
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(width: 1, color: Colors.black),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: Colors.black),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                    maxLines: 200,
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 180,
                    height: 34,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        FeatherIcons.upload,
                        size: 16,
                        color: AppTheme.colorBox('meeting_color_four'),
                      ),
                      label: Text(Languages.of(context).meetingButtonAttach,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color:
                                      AppTheme.colorBox('meeting_color_four'),
                                  fontWeight: FontWeight.w300)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        side: MaterialStateProperty.all<BorderSide>(
                          BorderSide(
                            width: 1.0,
                            color: AppTheme.colorBox('meeting_color_four'),
                          ),
                        ),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.colorBox('meeting_color_eight')),
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 90,
                    height: 34,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(Languages.of(context).meetingButtonSend,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color:
                                      AppTheme.colorBox('meeting_color_eight'),
                                  fontWeight: FontWeight.w300)),
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        // side: MaterialStateProperty.all<BorderSide>(
                        //   BorderSide(
                        //     width: 1.0,
                        //     color: AppTheme.colorBox('meeting_color_four'),
                        //   ),
                        // ),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.colorBox('meeting_color_four')),
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
                      child: Text(
                        Languages.of(context).meetingButtonSkip,
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: AppTheme.colorBox('meeting_color_eight'),
                            fontWeight: FontWeight.w300),
                      ),
                      style: ButtonStyle(
                        // side: MaterialStateProperty.all<BorderSide>(
                        //   BorderSide(
                        //     width: 1.0,
                        //     color: AppTheme.colorBox('meeting_color_four'),
                        //   ),
                        // ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        alignment: Alignment.center,
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppTheme.colorBox('meeting_color_nine')),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      );
    });
  }
}
