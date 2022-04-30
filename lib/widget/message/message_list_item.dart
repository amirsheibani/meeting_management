import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class MessagesItem extends StatefulWidget {
  const MessagesItem({Key? key, this.title, this.titleStyle, this.colors, this.iconColor, this.iconBackground, required this.onTap, this.fullname, this.subject, this.date, this.fullnameStyle, this.subjectStyle, this.dateStyle}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final List<Color>? colors;
  final Color? iconColor;
  final Color? iconBackground;
  final Function onTap;
  final String? fullname;
  final TextStyle? fullnameStyle;
  final String? subject;
  final TextStyle? subjectStyle;
  final String? date;
  final TextStyle? dateStyle;

  @override
  _MessagesItemState createState() => _MessagesItemState();
}

class _MessagesItemState extends State<MessagesItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,left: 8.0),
      child: InkWell(
        child: Container(
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.colors ?? [const Color(0x66FFFFFF), const Color(0x0DFFFFFF)],
            ),
          ),
          child: Row(
            children: [
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: widget.iconBackground ?? const Color(0xFFFFFFFF),
                    ),
                    child: Center(child: Icon(FeatherIcons.user, size: 16, color: widget.iconColor ?? const Color(0xFF00BBD0))),
                  ),
                  Text(widget.fullname ?? '',style: widget.fullnameStyle ?? const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500)),
                ],
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(widget.subject ?? '', style: widget.subjectStyle ?? const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 4.0,),
                  Text(widget.date ?? '', style: widget.subjectStyle ?? const TextStyle(color: Color(0xFF00BBD0), fontSize: 10, fontWeight: FontWeight.w200)),
                  const SizedBox(height: 4.0,),
                ],
              ),),
              const SizedBox(
                width: 8,
              ),
              SizedBox(
                width: 36,
                height: 36,
                child: Center(child: Icon(FeatherIcons.check, size: 16, color: widget.iconColor ?? const Color(0xFFFFFFFF))),
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        onTap: () {
          widget.onTap();
        },
      ),
    );
  }
}
