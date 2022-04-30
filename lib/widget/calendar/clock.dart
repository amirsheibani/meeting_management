import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


class MinClock extends StatefulWidget {
  const MinClock({Key? key, this.dateTime, this.color, this.strokeWidth, this.strokeWidthCircle}) : super(key: key);
  final DateTime? dateTime;
  final Color? color;
  final double? strokeWidth;
  final double? strokeWidthCircle;

  @override
  _MinClockState createState() => _MinClockState();
}

class _MinClockState extends State<MinClock> {
  DateTime? _dateTime;

  @override
  void initState() {
    if (widget.dateTime != null) {
      _dateTime = widget.dateTime;
    } else {
      _dateTime = DateTime.now();
      Timer.periodic(const Duration(seconds: 10), (Timer t){
        setState(() {
          _dateTime = DateTime.now();
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Transform.rotate(
          angle: -pi / 2,
          child: CustomPaint(
            size: Size.infinite,
            painter: WatchPainter(strokeWidth: widget.strokeWidth,strokeWidthCircle: widget.strokeWidthCircle, color: widget.color ?? Colors.black, dateTime: _dateTime),
          ),
        );
      },
    );
  }
}

class WatchPainter extends CustomPainter {
  WatchPainter({required this.color, this.strokeWidth, this.strokeWidthCircle,this.dateTime});

  final Color color;
  final double? strokeWidth;
  final double? strokeWidthCircle;
  final DateTime? dateTime;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = size.shortestSide / 2;
    final paint = Paint();
    paint.color = color;
    paint.strokeWidth = strokeWidthCircle ?? 4;
    paint.style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    //hour
    double hdx = center.dx + (size.shortestSide * 0.25) * cos((dateTime!.hour * 30 + dateTime!.minute * 0.5) * pi / 180);
    double hdy = center.dy + (size.shortestSide * 0.25) * sin((dateTime!.hour * 30 + dateTime!.minute * 0.5) * pi / 180);
    Offset ph = Offset(hdx, hdy);
    canvas.drawLine(center, ph, paint);

    //min
    double mdx = center.dx + (size.shortestSide * 0.35) * cos((dateTime!.minute * 6) * pi / 180);
    double mdy = center.dy + (size.shortestSide * 0.35) * sin((dateTime!.minute * 6) * pi / 180);
    Offset pm = Offset(mdx, mdy);
    canvas.drawLine(center, pm, paint);
  }

  @override
  bool shouldRepaint(WatchPainter oldDelegate) {
    return false;
  }
}
