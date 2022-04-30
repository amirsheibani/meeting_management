import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';

class NoteListItem extends StatefulWidget {
  const NoteListItem({Key? key, this.title, this.titleStyle, this.description, this.descriptionStyle, this.colors, this.iconColor, this.iconBackground, required this.onTap, this.icon, required this.onTapRemove}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final String? description;
  final TextStyle? descriptionStyle;
  final Widget? icon;
  final List<Color>? colors;
  final Color? iconColor;
  final Color? iconBackground;
  final Function onTap;
  final Function onTapRemove;

  @override
  _NoteListItemState createState() => _NoteListItemState();
}

class _NoteListItemState extends State<NoteListItem> {
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
              Tooltip(
                message: Languages.of(context).show,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.iconBackground ?? const Color(0xFF030F34),
                  ),
                  child: Center(child: widget.icon ?? const Text('15 Dec', style: TextStyle(color: Color(0xFF00BBD0), fontSize: 10, fontWeight: FontWeight.w500))),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0,),
                    Text(widget.title ?? 'Review the Presentation', style: widget.titleStyle ?? const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 4.0,),
                    Expanded(child: Text(widget.description ?? 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Amet ipsum senectus maecenas potenti ...', style: widget.titleStyle ?? const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w200))),
                    const SizedBox(height: 4.0,),
                  ],
                ),
              ),
              IconButton(icon:const Icon(FeatherIcons.trash2),iconSize: 24,color: const Color(0xFF00BBD0),tooltip: Languages.of(context).remove ,onPressed: () {
                widget.onTapRemove();
              },),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        onTap: (){
          widget.onTap();
        },
      ),
    );
  }
}

class NoteAddItem extends StatefulWidget {
  const NoteAddItem({Key? key, this.title, this.titleStyle, this.colors, this.iconColor, this.iconBackground, required this.onTap}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final List<Color>? colors;
  final Color? iconColor;
  final Color? iconBackground;
  final Function onTap;

  @override
  _NoteAddItemState createState() => _NoteAddItemState();
}

class _NoteAddItemState extends State<NoteAddItem> {
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
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.iconBackground ?? const Color(0xFF030F34),
                ),
                child: Center(child: Icon(FeatherIcons.plus, size: 16, color: widget.iconColor ?? const Color(0xFF00BBD0))),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(child: Text(widget.title ?? 'Add new note', style: widget.titleStyle ?? const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500))),
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
