import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class RememberMe extends StatefulWidget {
  const RememberMe(
      {Key? key,
      this.textStyle,
      this.iconColor,
      this.text,
      required this.onChange})
      : super(key: key);
  final TextStyle? textStyle;
  final Color? iconColor;
  final String? text;
  final Function onChange;

  @override
  _RememberMeState createState() => _RememberMeState();
}

class _RememberMeState extends State<RememberMe> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      horizontalTitleGap: 0,
      leading: Icon(
        isChecked ? FeatherIcons.checkSquare : FeatherIcons.square,
        color: widget.iconColor ?? Colors.blueGrey,
        size: 24,
      ),
      title: Text(
        widget.text ?? '',
        style: widget.textStyle ??
            const TextStyle(fontSize: 20, color: Colors.white),
      ),
      onTap: () {
        setState(
          () {
            isChecked = !isChecked;
            widget.onChange(isChecked);
          },
        );
      },
    );
  }
}
