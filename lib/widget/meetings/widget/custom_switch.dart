import 'package:flutter/material.dart';
import 'package:meeting_management/language/languages/languages.dart';


class CustomSwitch extends StatefulWidget {
  const CustomSwitch({Key? key, this.canceled, this.textStyle, this.trackColor, this.inactiveThumbColor, this.activeColor}) : super(key: key);
  final bool? canceled;
  final TextStyle? textStyle;
  final Color? trackColor;
  final Color? inactiveThumbColor;
  final Color? activeColor;

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool isSwitchOn = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: AbsorbPointer(
              absorbing: widget.canceled != null
                  ? widget.canceled!
                      ? true
                      : false
                  : false,
              child: Switch(
                // activeColor: widget.canceled != null
                //     ? widget.canceled!
                //         ? const Color(0xFFC4C4C4)
                //         : const Color(0xFF030F34)
                //     : const Color(0xFF030F34),
                activeColor: widget.activeColor ??const Color(0xFF030F34) ,
                activeTrackColor:widget.trackColor?? const Color(0xFFFFFFFF),
                inactiveThumbColor:widget.inactiveThumbColor?? const Color(0xFF00BBD0),
                inactiveTrackColor:widget.trackColor?? const Color(0xFFFFFFFF),
                value: isSwitchOn,
                onChanged: (bool value) {
                  setState(
                    () {
                      isSwitchOn = value;
                    },
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              Languages.of(context).meetingReminder,
              style: widget.textStyle ??
                  const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFFFFFFF),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
