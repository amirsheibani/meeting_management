import 'dart:async';
import 'dart:math' as math;
import 'dart:ui';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';

class FirstSlide extends StatefulWidget {
  const FirstSlide({Key? key, required this.bottomImage, required this.description,}) : super(key: key);
  final Widget bottomImage;
  final String description;

  @override
  _FirstSlideState createState() => _FirstSlideState();
}

class _FirstSlideState extends State<FirstSlide> with TickerProviderStateMixin {

  late final AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return constraints.maxWidth > 600
            ? Row(
          children: [
            SizedBox(
              width: constraints.maxWidth / 2,
              child: Text(
                widget.description,
                style: Theme.of(context).textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: AppTheme.colorBox('meetings_color_one'),
                ),
              ),
            ),
            SizedBox(
              width: constraints.maxWidth / 2,
              child: Stack(
                children: [
                  Positioned(
                    right:LanguageState.language == Language.en? (constraints.maxWidth) / 6:null,
                    left: LanguageState.language == Language.en? null : (constraints.maxWidth) / 6,
                    top: (constraints.maxHeight - (constraints.maxWidth / 6)) / 2,
                    child: SizedBox(
                      width: constraints.maxWidth / 6,
                      height: constraints.maxWidth / 6,
                      child: widget.bottomImage,
                    ),
                  ),
                  Positioned(
                    right:LanguageState.language == Language.en? (constraints.maxWidth) / 6:null,
                    left: LanguageState.language == Language.en? null : (constraints.maxWidth) / 6,
                    top: (constraints.maxHeight - (constraints.maxWidth / 6)) / 2,
                   child:  SizedBox(
                     width: constraints.maxWidth / 6,
                     height: constraints.maxWidth / 6,
                     child: AnimatedBuilder(
                       animation: _controller,
                       child: RepaintBoundary(
                         child: CustomPaint(
                           painter: ClockHandPainter(color:AppTheme.colorBox('meeting_color_four'), ),
                         ),
                       ),
                       builder: (BuildContext context, Widget? child) {
                         return Transform.rotate(
                           angle: _controller.value * 2 * math.pi,
                           child: child,
                         );
                       },
                     ),
                   ),
                  ),
                ],
              ),
            ),
          ],
        )
            :
        Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight*0.6,
              child: Stack(
                children: [
                  Positioned(
                    right:(constraints.maxWidth -constraints.maxWidth / 2 )/2 ,
                    top: (constraints.maxHeight - (constraints.maxWidth / 2)) / 3,
                    child: SizedBox(
                      width: constraints.maxWidth / 2,
                      height: constraints.maxWidth / 2,
                      child: widget.bottomImage,
                    ),
                  ),

                  Positioned(
                    right:(constraints.maxWidth -constraints.maxWidth / 2 )/2 ,
                    top: (constraints.maxHeight - (constraints.maxWidth / 2)) / 3,
                    child: SizedBox(
                      width: constraints.maxWidth / 2,
                      height: constraints.maxWidth / 2,
                      child: AnimatedBuilder(
                        animation: _controller,
                        child: RepaintBoundary(
                          child: CustomPaint(
                            painter: ClockHandPainter(color:AppTheme.colorBox('meeting_color_four'), ),
                          ),
                        ),
                        builder: (BuildContext context, Widget? child) {
                          return Transform.rotate(
                            angle: _controller.value * 2 * math.pi,
                            child: child,
                          );
                        },
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30,),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.colorBox('meetings_color_one'),
              ),
            ),
          ],
        );
      },
    );
  }
}
class ClockHandPainter extends CustomPainter {
  ClockHandPainter( {required this.color, this.strokeWidth, this.strokeWidthCircle});

  final Color color;
  final double? strokeWidth;
  final double? strokeWidthCircle;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width/2, size.height/2);
    final paint = Paint();
    paint.color = color;
    paint.strokeWidth = strokeWidthCircle ?? 6;
    paint.style = PaintingStyle.stroke;


    //hour
    double hdx = center.dx;
    double hdy = center.dy-size.width/5;
    Offset ph = Offset(hdx, hdy);
    canvas.drawLine(center, ph, paint);

    //min
    double mdx = center.dx + size.width/7;
    double mdy = center.dy +size.width/5;
    Offset pm = Offset(mdx, mdy);
    canvas.drawLine(center, pm, paint);
  }

  @override
  bool shouldRepaint(ClockHandPainter oldDelegate) {
    return false;
  }
}
