
import 'package:flutter/material.dart';
import 'package:meeting_management/constant.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    Key? key,
    this.title,
    this.height,
    this.autofocus,
    this.focusNode,
    this.keyboardType,
    required this.obscureText,
    this.hintTitle,
    this.icon,
    this.description,
    this.width,
    this.titleColor,
    this.textColor,
    this.hintColor,
    this.errorColor,
    this.helperColor,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.backgroundColor,
    this.cursorColor,
    required this.validations,
    required this.controller,
    required this.onFieldSubmittedFunction,
    this.maxLines,
    this.readOnly,
    this.alignmentCenterLeft,
    this.titleStyle,
    this.textFieldTextStyle,
    this.helperStyle,
    this.errorStyle,
    this.hintTextStyle,
    this.helperMaxLines,
    this.prefixIconConstraintsMinHeight,
    this.prefixIconConstraintsMinWidth,
    this.borderRadiusCircular,
    this.onChanged, this.textFieldAlignment, this.suffixIcon, this.visibilityIconColor,
  })  :super(key: key);
  final String? title;
  final String? hintTitle;
  final double? height;
  final double? width;
  final bool? autofocus;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool obscureText;
  final IconData? icon;
  final String? description;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? errorColor;
  final Color? helperColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? cursorColor;
  final Color? visibilityIconColor;
  final int? maxLines;
  final bool? readOnly;
  final List<Function> validations;
  final TextEditingController controller;
  final Function(String value) onFieldSubmittedFunction;
  final bool? alignmentCenterLeft;
  final TextStyle? titleStyle;
  final TextStyle? textFieldTextStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextStyle? hintTextStyle;
  final int? helperMaxLines;
  final double? prefixIconConstraintsMinHeight;
  final double? prefixIconConstraintsMinWidth;
  final double? borderRadiusCircular;
  final Function(String value)? onChanged;
  final TextDirection? textFieldAlignment;
  final Widget? suffixIcon;



  @override
  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  bool _obscureText = false;

  // final TextEditingController _controller = TextEditingController();
  final _formTextFieldKey = GlobalKey<FormFieldState>();

  @override
  void initState() {

      _obscureText = widget.obscureText;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Container(
            width: widget.width ?? double.infinity,
            alignment: widget.alignmentCenterLeft ?? true ? Alignment.centerLeft : Alignment.centerRight,
            // alignment: context.read<LanguageController>().isLeftToRight() ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              widget.title ?? '',
              style: Theme.of(context).textTheme.subtitle1!.apply(color: widget.titleColor).copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        Container(
          color:widget.backgroundColor ?? Colors.transparent,
          child: TextFormField(
              textDirection: widget.textFieldAlignment,
              // textAlign: widget.textFieldAlignment == null? TextAlign.start :widget.textFieldAlignment!  ,
              onFieldSubmitted: widget.onFieldSubmittedFunction,
              readOnly: widget.readOnly??false,
              key: _formTextFieldKey,
              controller: widget.controller,
              autofocus: widget.autofocus ?? false,
              focusNode: widget.focusNode,
              keyboardType: widget.keyboardType ?? TextInputType.text,
              autocorrect: false,
              maxLines: widget.maxLines??1,
              style:widget.textFieldTextStyle?? TextStyle(height:1,color: widget.textColor ?? Colors.black54,fontSize: 17,fontWeight: FontWeight.w400),
              obscureText: _obscureText,
              decoration: InputDecoration(
                suffixIcon: widget.obscureText
                    ? IconButton(color: widget.visibilityIconColor??Colors.white,
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    })
                    : widget.suffixIcon,
                prefixIcon: widget.icon != null
                    ? Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Icon(
                    widget.icon,
                    color: widget.helperColor,
                  ),
                )
                    : null,
                prefixIconConstraints: widget.icon != null
                    ? const BoxConstraints(
                  minHeight: 32,
                  minWidth: 32,
                )
                    : null,
                errorStyle: widget.errorStyle??Theme.of(context).textTheme.caption!.apply(color: widget.errorColor).copyWith(fontWeight: FontWeight.normal),
                helperText: widget.description ?? '',
                helperStyle: widget.helperStyle ?? TextStyle(color: widget.helperColor ?? Colors.green,fontSize: 12,fontWeight: FontWeight.normal),
                helperMaxLines: widget.helperMaxLines ?? 1,
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.errorColor??Colors.red, width: 1.5),
                  borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.enabledBorderColor??Colors.blue, width: 1.5),
                  borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.focusedBorderColor??Colors.lightGreen, width: 1.5),
                  borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.errorColor??Colors.red, width: 1.5),
                  borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                ),
                alignLabelWithHint: true,
                hintText: widget.hintTitle??'',
                hintStyle:widget.hintTextStyle?? TextStyle(color: widget.hintColor ??Colors.grey,fontSize: 17,fontWeight: FontWeight.w300),
              ),
              cursorColor: widget.cursorColor ??Colors.blue,
              validator: (value) {
                String? message;
                for (Function validator in widget.validations) {
                  message = validator(value);
                  if (message != null) {
                    break;
                  }
                }
                return message;
              },
              onChanged: (value) {
                if (!widget.obscureText) {
                  if (widget.keyboardType != TextInputType.emailAddress && widget.keyboardType != TextInputType.visiblePassword) {
                    widget.controller.text = widget.controller.text.changeCharacterWithLanguage();
                    widget.controller.text = widget.controller.text.convertNumberWithLanguage();
                    // .changeSeqWithLanguage();
                  }
                }
                widget.controller.selection = TextSelection.fromPosition(TextPosition(offset: widget.controller.text.length));
                _formTextFieldKey.currentState!.validate();
              }),
        ),
      ],
    );
  }
}
