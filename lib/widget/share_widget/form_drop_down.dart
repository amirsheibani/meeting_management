
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class FormDropDown extends StatefulWidget {
  const FormDropDown(
      {Key? key,
        this.title,
        required this.items,
        this.height,
        this.autofocus,
        // this.focusNode,
        this.description,
        this.width,
        this.titleColor,
        this.textColor,
        this.hintStyle,
        this.errorColor,
        this.helperColor,
        this.enabledBorderColor,
        this.focusedBorderColor,
        this.errorBorderColor,
        this.primaryBackgroundColor,
        this.secondaryBackgroundColor,
        this.cursorColor,
        required this.validations,
        // this.nextFocus,
        this.readOnly,
        this.alignmentCenterLeft,
        this.titleStyle,
        this.errorStyle,
        this.helperStyle,
        this.dropdownMenuItemStyle,
        this.errorMaxLines,
        this.helperMaxLines,
        this.borderRadiusCircular,
        this.firstItemSelectMessage, required this.onChange, this.defaultValue, this.valueStyle, this.iconColor,
      })
      :super(key: key);
  final String? title;
  final String? defaultValue;
  final String? firstItemSelectMessage;
  final Map<String,dynamic> items;
  final double? height;
  final double? width;
  final bool? autofocus;
  // final FocusNode? focusNode;
  final String? description;
  final Color? titleColor;
  final Color? primaryBackgroundColor;
  final Color? secondaryBackgroundColor;
  final Color? textColor;
  final TextStyle? hintStyle;
  final Color? errorColor;
  final Color? helperColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? cursorColor;
  final Color? iconColor;
  final List<Function> validations;
  final Function(String value) onChange;
  final bool? readOnly;
  // final FocusNode? nextFocus;
  final bool? alignmentCenterLeft;
  final TextStyle? titleStyle;
  final TextStyle? errorStyle;
  final TextStyle? helperStyle;
  final TextStyle? dropdownMenuItemStyle;
  final int? errorMaxLines;
  final int? helperMaxLines;
  final double? borderRadiusCircular;
  final TextStyle? valueStyle;


  @override
  _FormDropDownState createState() => _FormDropDownState();
}

class _FormDropDownState extends State<FormDropDown> {
  String? _currentSelectedValue;
  bool hasFocus = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_currentSelectedValue == null || widget.items.keys.where((element) => element.toLowerCase() == _currentSelectedValue!.toLowerCase()).toList().isEmpty){
      if(widget.defaultValue != null){
        if(widget.items.keys.where((element) => element.toLowerCase() == widget.defaultValue!.toLowerCase()).toList().isNotEmpty){
          _currentSelectedValue = widget.defaultValue;
        }
        else{
          _currentSelectedValue = widget.items.keys.first;
        }
      }else{
        if(widget.items.keys.length > 0){
          _currentSelectedValue = widget.items.keys.first;
        }else{
          _currentSelectedValue = '';
        }
      }
    }
    return Column(
      children: [
        if(widget.title!=null)
        Container(
          // height: widget.height??80 / 2,
          width: widget.width ??double.infinity ,
          alignment: widget.alignmentCenterLeft ?? false ? Alignment.centerLeft : Alignment.centerRight,
          child: Text(
            widget.title ?? 'title',
            style:widget.titleStyle?? TextStyle(color: widget.titleColor ??const Color(0xFFBBBBBB),fontSize: 17,fontWeight: FontWeight.w700),
          ),
        ),
        if(widget.title!=null)
          const SizedBox(height: 8,),
        SizedBox(
          // height: widget.height ?? 76,
          child: FormField<String>(
            enabled: widget.readOnly ?? false,
            builder: (FormFieldState<String> state) {
              return InputDecorator(
                // isFocused: widget.focusNode!.hasFocus,
                decoration: InputDecoration(
                  // hintText: widget.items.keys.first,
                  // hintStyle: widget.hintStyle,
                  filled: true,
                  fillColor: widget.primaryBackgroundColor??Colors.white,
                  errorStyle:widget.errorStyle?? TextStyle(color: widget.errorColor ?? Colors.red ,fontSize: 12,fontWeight: FontWeight.normal),
                  errorMaxLines: widget.errorMaxLines??3,
                  helperText: widget.description?? '',
                  helperStyle:widget.helperStyle??TextStyle(color: widget.helperColor ?? Colors.green,fontSize: 12,fontWeight: FontWeight.normal),
                  helperMaxLines:widget.helperMaxLines?? 1,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.enabledBorderColor ??Colors.blue, width: 1.5),
                    borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.focusedBorderColor??Colors.lightGreen, width: 1.5),
                    borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: widget.errorBorderColor??Colors.red, width: 1.5),
                    borderRadius:  BorderRadius.all(Radius.circular(widget.borderRadiusCircular??8)),
                  ),
                  errorText: state.errorText,
                ),
                isEmpty: _currentSelectedValue == widget.items.keys.first,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    style: widget.valueStyle ?? TextStyle(color: widget.textColor ?? Colors.red,fontSize: 17,fontWeight: FontWeight.w400),
                    // focusNode:widget.focusNode ,
                    itemHeight: 48,
                    // iconSize: 18,
                    icon: Icon(FeatherIcons.chevronDown, size: 25,color: widget.iconColor??Colors.blue),
                    dropdownColor: widget.secondaryBackgroundColor??const Color(0xFFF0F0F0),
                    elevation: 0,
                    value: _currentSelectedValue,
                    isDense: true,
                    onChanged: (newValue) {
                      // widget.focusNode!.unfocus();
                      // FocusScope.of(context).requestFocus(widget.nextFocus);
                      setState(() {
                        _currentSelectedValue = newValue!;
                        state.didChange(newValue);
                        state.validate();
                      });
                    },
                    items: widget.items.keys.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style:widget.dropdownMenuItemStyle??TextStyle(color: widget.textColor ?? Colors.grey,fontSize: 12,fontWeight: FontWeight.normal),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
            validator: (key) {
              String? message;

              if(widget.items[_currentSelectedValue] == null){
                return widget.firstItemSelectMessage ?? 'You must select another item';
              }
              // for (var validator in widget.validations) {
              //   message = validator(key,widget.items[key]);
              // }
              if(message == null){
                // widget.onChange(widget.items[_currentSelectedValue]);
                widget.onChange(_currentSelectedValue!);
              }
              return message;
            },
          ),
        ),
      ],
    );
  }
}

