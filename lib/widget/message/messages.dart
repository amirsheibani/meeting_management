import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/message/new_message.dart';


import 'message_list_item.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key, this.title, this.titleStyle, this.subTitle, this.subTitleStyle, this.background, this.list}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final String? subTitle;
  final TextStyle? subTitleStyle;
  final List<MessagesItem>? list;
  final Color? background;

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  late List<Widget> _items;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    if (widget.list != null) {
      _items = widget.list!;
    } else {
      _items = [
        MessagesItem(
          onTap: () {},
          subject: LanguageState.language == Language.en ? 'Meeting report' : 'گزارش جلسه',
          date: LanguageState.language == Language.en ? '1 hour ago' : '1 ساعت قبل'.convertNumberWithLanguage(),
          fullname: LanguageState.language == Language.en ? 'Mohammad' : 'محمد',
        ),
      ];
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.colorBox('meeting_color_four') ?? const Color(0xFF030F34),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
            width: double.maxFinite,
            child: ListTile(
              leading: Icon(
                FeatherIcons.mail,
                size: 32.0,
                color: AppTheme.colorBox('meeting_color_eight'),
              ),
              title: Text(
                widget.title ?? 'Messages',
                style: widget.titleStyle ?? const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                widget.subTitle ?? 'No new message',
                style: widget.subTitleStyle ?? const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),
              ),
              trailing: IconButton(
                padding: const EdgeInsets.all(0.0),
                iconSize: 32.0,
                icon: Icon(
                  FeatherIcons.plusCircle,
                  color: AppTheme.colorBox('meeting_color_eight'),
                ),
                onPressed: (){
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
                          return DialogFrameWidget(
                            widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.7,
                            heightScale: 0.7,
                            leading: Icon(FeatherIcons.messageCircle, size: 48, color: AppTheme.colorBox('meeting_color_four')),
                            title: Text(Languages.of(context).meetingMessageTitle, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four'))),
                            headerColor: AppTheme.colorBox('meeting_color_eight'),
                            headerHeight: 80,
                            background: AppTheme.colorBox('meeting_color_eight'),
                            dismissColorIcon: AppTheme.colorBox('meeting_color_four'),
                            child: const NewMessageWidget(),
                          );
                        }),
                      );
                    },
                    barrierColor: Colors.transparent,
                  ).then((value) {
                    if (value != null) {}
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.separated(
                  controller: ScrollController(),
                  itemBuilder: (BuildContext context, int index) {
                    return _items[index];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8.0,
                    );
                  },
                  itemCount: _items.length),
            ),
          ),
        ],
      ),
    );
  }
}
