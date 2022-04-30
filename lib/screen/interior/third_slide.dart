import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';

class ThirdSlide extends StatefulWidget {
  const ThirdSlide({
    Key? key,
    required this.bottomImage,
    required this.description,
    required this.upperImage,
  }) : super(key: key);
  final Widget bottomImage;
  final Widget upperImage;
  final String description;

  // final Duration horizontalAnimationDuration;

  @override
  _ThirdSlideState createState() => _ThirdSlideState();
}

class _ThirdSlideState extends State<ThirdSlide> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late Timer _timer;
  late final AnimationController _firstCircleFadeAnimationController;
  late Animation<double> _firstCircleFadeAnimation;
  late final AnimationController _secondCircleFadeAnimationController;
  late Animation<double> _secondCircleFadeAnimation;
  late final AnimationController _thirdCircleFadeAnimationController;
  late Animation<double> _thirdCircleFadeAnimation;

  @override
  void dispose() {
    _firstCircleFadeAnimationController.dispose();
    _secondCircleFadeAnimationController.dispose();
    _thirdCircleFadeAnimationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _firstCircleFadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _secondCircleFadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _thirdCircleFadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _firstCircleFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_firstCircleFadeAnimationController);
    _secondCircleFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_secondCircleFadeAnimationController);
    _thirdCircleFadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_thirdCircleFadeAnimationController);

    _timer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      _firstCircleFadeAnimationController.forward().whenComplete(() {
        _secondCircleFadeAnimationController.forward().whenComplete(() {
          _thirdCircleFadeAnimationController.forward().whenComplete(() {
            _firstCircleFadeAnimationController.reverse().whenComplete(() {
              _secondCircleFadeAnimationController.reverse().whenComplete(() {
                _thirdCircleFadeAnimationController.reverse();
              });
            });
          });
        });
      });
      // _timer.cancel();

    });
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

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
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one')),
                    ),
                  ),
                  SizedBox(
                    width: constraints.maxWidth / 2,
                    child: Stack(
                      children: [
                        Positioned(
                          right: LanguageState.language == Language.en ? (constraints.maxWidth) / 6 : null,
                          left: LanguageState.language == Language.en ? null : (constraints.maxWidth) / 6,
                          top: (constraints.maxHeight - (constraints.maxWidth / 6)) / 2,
                          child: SizedBox(
                            width: constraints.maxWidth / 6,
                            height: constraints.maxWidth / 6,
                            child: widget.bottomImage,
                          ),
                        ),
                        Positioned(
                          right:  ((constraints.maxWidth) / 6) + constraints.maxWidth * 0.02 ,
                          top: ((constraints.maxHeight - (constraints.maxWidth / 6)) / 2) + (constraints.maxWidth / 6) / 3.5,
                          child: FadeTransition(
                            opacity: _firstCircleFadeAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.01,
                              height: constraints.maxWidth * 0.01,
                            ),
                          ),
                        ),
                        Positioned(
                          right: ((constraints.maxWidth) / 6) + constraints.maxWidth / 29,
                          top: ((constraints.maxHeight - (constraints.maxWidth / 6)) / 2) + (constraints.maxWidth / 6) / 3.5,
                          child: FadeTransition(
                            opacity: _secondCircleFadeAnimation,
                            child: Container(
                              decoration:  BoxDecoration(
                                color: AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.01,
                              height: constraints.maxWidth * 0.01,
                            ),
                          ),
                        ),
                        Positioned(
                          right: ((constraints.maxWidth) / 6) + constraints.maxWidth / 20,
                          top: ((constraints.maxHeight - (constraints.maxWidth / 6)) / 2) + (constraints.maxWidth / 6) / 3.5,
                          child: FadeTransition(
                            opacity: _thirdCircleFadeAnimation,
                            child: Container(
                              decoration:  BoxDecoration(
                                color: AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.01,
                              height: constraints.maxWidth * 0.01,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight*0.6,
                    child: Stack(
                      children: [
                        Positioned(
                          right:(constraints.maxWidth -constraints.maxWidth / 2.5 )/2 ,
                          top: (constraints.maxHeight - (constraints.maxWidth / 2.5)) / 3,
                          child: SizedBox(
                            width: constraints.maxWidth / 2.5,
                            height: constraints.maxWidth / 2.5,
                            child: widget.bottomImage,
                          ),
                        ),
                        Positioned(
                          right:(constraints.maxWidth -constraints.maxWidth / 2.5 )/2 + constraints.maxWidth * 0.04,
                          top: (constraints.maxHeight - (constraints.maxWidth / 2.5)) / 3 + constraints.maxWidth / 9,
                          child: FadeTransition(
                            opacity: _firstCircleFadeAnimation,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.03,
                              height: constraints.maxWidth * 0.03,
                            ),
                          ),
                        ),
                        Positioned(
                          right:(constraints.maxWidth -constraints.maxWidth / 2.5 )/2 + constraints.maxWidth / 13  ,
                          top: (constraints.maxHeight - (constraints.maxWidth / 2.5)) / 3 + constraints.maxWidth / 9,
                          child: FadeTransition(
                            opacity: _secondCircleFadeAnimation,
                            child: Container(
                              decoration:BoxDecoration(
                                color:AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.03,
                              height: constraints.maxWidth * 0.03,
                            ),
                          ),
                        ),
                        Positioned(
                          right:(constraints.maxWidth -constraints.maxWidth / 2.5 )/2 + constraints.maxWidth / 9 ,
                          top: (constraints.maxHeight - (constraints.maxWidth / 2.5)) / 3 + constraints.maxWidth / 9,
                          child: FadeTransition(
                            opacity: _thirdCircleFadeAnimation,
                            child: Container(
                              decoration:  BoxDecoration(
                                color: AppTheme.colorBox('meeting_color_four'),
                                shape: BoxShape.circle,
                              ),
                              width: constraints.maxWidth * 0.03,
                              height: constraints.maxWidth * 0.03,
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
