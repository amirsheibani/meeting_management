import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';

class SecondSlide extends StatefulWidget {
  const SecondSlide({Key? key, required this.bottomImage, required this.description, required this.upperImage,}) : super(key: key);
  final Widget bottomImage;
  final Widget upperImage;
  final String description;

  @override
  _SecondSlideState createState() => _SecondSlideState();
}

class _SecondSlideState extends State<SecondSlide> with TickerProviderStateMixin {

  late final AnimationController _fadeAnimationController;
  late Animation<double> _fadeAnimation;
  late Timer _timer;

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeAnimationController);
   _timer= Timer(const Duration(milliseconds: 1000),(){
     _timer.cancel();
      _fadeAnimationController.forward();
    });
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
                    left: LanguageState.language == Language.en? null : (constraints.maxWidth) / 6 + constraints.maxWidth /12,
                    top: (constraints.maxHeight - (constraints.maxWidth / 6)) / 2,
                    child: FadeTransition(
                      // opacity: _showingPencil,
                      // duration: const Duration(milliseconds: 1000),
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: constraints.maxWidth / 14,
                        height: constraints.maxWidth / 10,
                        child: widget.upperImage,
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
                    top: (constraints.maxHeight - (constraints.maxWidth / 2 )) / 3,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      // opacity: _showingPencil,
                      // duration: const Duration(milliseconds: 1000),
                      child: SizedBox(
                        width: constraints.maxWidth / 4,
                        height: constraints.maxWidth / 4.5,
                        child: widget.upperImage,
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
