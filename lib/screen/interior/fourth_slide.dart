import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/theme/theme.dart';

class FourthSlide extends StatefulWidget {
  const FourthSlide({Key? key, required this.bottomImage, required this.description, required this.upperImage, required this.pencilHorizontalAnimationDuration}) : super(key: key);
  final Widget bottomImage;
  final Widget upperImage;
  final String description;
  final Duration pencilHorizontalAnimationDuration;

  @override
  _FourthSlideState createState() => _FourthSlideState();
}

class _FourthSlideState extends State<FourthSlide> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late final AnimationController _horizontalAnimationController;

  late final AnimationController _verticalAnimationController;
  late final AnimationController _fadeAnimationController;

  late Animation<Offset> _horizontalAnimation;

  late Animation<Offset> _verticalAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void dispose() {
    _horizontalAnimationController.dispose();
    _verticalAnimationController.dispose();
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _horizontalAnimationController = AnimationController(vsync: this, duration: widget.pencilHorizontalAnimationDuration)..repeat(reverse: true);
    _verticalAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: (widget.pencilHorizontalAnimationDuration.inMilliseconds / 4).round()))..repeat(reverse: true);
    _fadeAnimationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    _horizontalAnimation = Tween(begin: Offset.zero, end: const Offset(0.1, 0)).animate(_horizontalAnimationController);
    _verticalAnimation = Tween(begin: Offset.zero, end: const Offset(0, 0.1)).animate(_verticalAnimationController);
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeAnimationController);
    _fadeAnimationController.forward();
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
                            child: SlideTransition(
                              position: _horizontalAnimation,
                              child: SlideTransition(
                                position: _verticalAnimation,
                                child: SizedBox(
                                  width: constraints.maxWidth / 14,
                                  height: constraints.maxWidth / 10,
                                  child: widget.upperImage,
                                ),
                              ),
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
                            child: SlideTransition(
                              position: _horizontalAnimation,
                              child: SlideTransition(
                                position: _verticalAnimation,
                                child: SizedBox(
                                  width: constraints.maxWidth / 4,
                                  height: constraints.maxWidth / 4.5,
                                  child: widget.upperImage,
                                ),
                              ),
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
