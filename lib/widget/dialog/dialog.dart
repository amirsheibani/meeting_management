import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DialogFrameWidget extends StatefulWidget {
  const DialogFrameWidget({Key? key, this.height,this.width, this.headerHeight, this.background, this.headerColor,this.widthScale = 1,this.heightScale = 1, required this.child, this.title, this.leading, this.border, this.dismissColorIcon}) : super(key: key);
  final double? headerHeight;
  final Color? background;
  final Color? dismissColorIcon;
  final BoxBorder? border;
  final Color? headerColor;
  final Widget? title;
  final Widget? leading;
  final double? widthScale;
  final double? heightScale;
  final double? width;
  final double? height;
  final Widget child;


  @override
  _DialogFrameWidgetState createState() => _DialogFrameWidgetState();
}

class _DialogFrameWidgetState extends State<DialogFrameWidget> {
  @override
  Widget build(BuildContext context) {
    if(widget.width != null || widget.height != null){
      return Container(
        width: widget.width ?? double.maxFinite,
        height: widget.height ?? double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: widget.background ?? const Color(0xFFF0F1F3),
          // border: widget.border ?? Border.all(width: 1,color: Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.headerHeight ?? 45,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                color: widget.headerColor ?? const Color(0xFF030F34),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  if(widget.leading != null)
                    widget.leading!,
                  if(widget.title != null)
                    const SizedBox(width: 8),
                  if(widget.title != null)
                    widget.title!,
                  const Spacer(
                  ),
                  IconButton(
                    color: widget.dismissColorIcon,
                    padding: const EdgeInsets.only(bottom: 2),
                    icon: Icon(
                      FeatherIcons.xCircle,
                      size: 36,
                      color: widget.dismissColorIcon ?? Colors.white ,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Expanded(child: widget.child),
          ],
        ),
      );
    }else{
      return LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth * widget.widthScale!,
          height: constraints.maxHeight * widget.heightScale!,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: widget.background ?? const Color(0xFFF0F1F3),
            // border: widget.border ?? Border.all(width: 1,color: Colors.black),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: widget.headerHeight ?? 45,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  color: widget.headerColor ?? const Color(0xFF030F34),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    if(widget.leading != null)
                      widget.leading!,
                    if(widget.title != null)
                      const SizedBox(width: 8),
                    if(widget.title != null)
                      widget.title!,
                    const Spacer(
                    ),
                    IconButton(
                      padding: const EdgeInsets.only(bottom: 2),
                      icon: Icon(
                        FeatherIcons.xCircle,
                        size: 36,
                        color: widget.dismissColorIcon ?? Colors.white ,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              Expanded(child: widget.child),
            ],
          ),
        );
      });
    }
  }
}
