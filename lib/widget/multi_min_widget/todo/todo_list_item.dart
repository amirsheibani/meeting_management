import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({Key? key, this.title, this.titleStyle, this.icon, this.iconColor, this.iconBackground, required this.onTap, this.done = false, required this.onTapEdit}) : super(key: key);
  final String? title;
  final TextStyle? titleStyle;
  final Widget? icon;
  final Color? iconColor;
  final Color? iconBackground;
  final bool? done;
  final Function onTap;
  final Function onTapEdit;
  @override
  _TodoListItemState createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  TextStyle? _textStyle;
  @override
  void initState() {
    if(widget.done!){
      _textStyle = const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500,decorationColor: Color(0xFFB00020), decoration: TextDecoration.lineThrough);
    }else{
      _textStyle = const TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w500);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return ListTile(
      minLeadingWidth: 8,
      leading: IconButton(
        icon: widget.icon ?? Icon(
          widget.done! ? FeatherIcons.checkCircle :FeatherIcons.circle,
          size: 12,
          color: Colors.black,
        ), onPressed: () {
          widget.onTap();
      },
      ),
      title: Text(
        widget.title ?? 'new',
        style: widget.titleStyle ?? _textStyle,
      ),
      onTap: (){
        widget.onTapEdit();
      },
    );
  }
}
