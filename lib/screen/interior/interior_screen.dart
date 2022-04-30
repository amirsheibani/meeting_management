import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/screen/interior/first_slide.dart';
import 'package:meeting_management/screen/interior/fourth_slide.dart';
import 'package:meeting_management/screen/interior/last_slide.dart';
import 'package:meeting_management/screen/interior/second_slide.dart';
import 'package:meeting_management/screen/interior/third_slide.dart';
import 'package:meeting_management/theme/bloc/theme_bloc.dart';
import 'package:meeting_management/theme/bloc/theme_event.dart';
import 'package:meeting_management/theme/theme.dart';

class InteriorScreen extends StatefulWidget {
  const InteriorScreen({Key? key}) : super(key: key);

  @override
  _InteriorScreenState createState() => _InteriorScreenState();
}

class _InteriorScreenState extends State<InteriorScreen> with WidgetsBindingObserver {
  bool timeStarted = false;
  final PageController _pageController = PageController();
  int _pageNumber = 0;
  List<Widget> _pagesList = [];
  late Timer _timer;
  bool skipButtonShown = true;

  @override
  void initState() {
    context.read<ThemeBloc>().add(LoadThemeEvent());
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageNumber < _pagesList.length - 1) {
        _pageNumber++;
        if (_pageNumber == _pagesList.length - 1) {
          setState(() {
            skipButtonShown = false;
            _pageController.animateToPage(
              _pageNumber,
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeInOut,
            );
          });
        } else {
          _pageController.animateToPage(
            _pageNumber,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
          );
        }
      } else {
        timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // if(_timer != null){
    //   _timer!.cancel();
    // }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    context.read<ThemeBloc>().add(LoadThemeEvent());
  }

  @override
  void didChangePlatformBrightness() {
    context.read<ThemeBloc>().add(LoadThemeEvent());
  }

  @override
  Widget build(BuildContext context) {
    _pagesList = [
      FirstSlide(
        description: Languages.of(context).interiorSetAlarm,
        bottomImage: Image.asset(
          'assets/images/alarm.png',
        ),
      ),
      SecondSlide(
        description: Languages.of(context).interiorMakeTodoList,
        bottomImage: Image.asset(
          'assets/images/toDoList.png',
        ), upperImage: Image.asset(
        'assets/images/check.png',
      ),
      ),
      ThirdSlide(
        description: Languages.of(context).interiorCheckEmail,
        bottomImage: Image.asset(
          'assets/images/email.png',
        ),
        upperImage:  Image.asset(
          'assets/images/dots.png',fit: BoxFit.scaleDown,),
      ),
      FourthSlide(
        pencilHorizontalAnimationDuration: const Duration(milliseconds: 2000),
        description: Languages.of(context).interiorSaveNote,
        bottomImage: Image.asset(
          'assets/images/note.png',
        ),
        upperImage: Image.asset('assets/images/pencil.png'),
      ),
      // FourthSlide(
      //   description: Languages.of(context).interiorSetMeeting,
      //   bottomImage: Image.asset(
      //     'assets/images/meeting.png',
      //   ),
      // ),
      LastSlide(
          description: Languages.of(context).interiorHaveAll,
          image: Image.asset(
            'assets/images/phone.png',
          ),),
    ];

    return Scaffold(
      body: Center(
        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(color: AppTheme.colorBox('meeting_color_eighteen')),
            child: Padding(
              padding: constraints.maxWidth > 600 ? const EdgeInsets.fromLTRB(150, 0, 150, 0) : const EdgeInsets.fromLTRB(40, 0, 40, 0),
              child: Stack(
                children: [
                  PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    children: _pagesList,
                  ),
                  if (skipButtonShown)
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextButton(
                        onPressed: () {
                          _timer.cancel();
                          setState(() {
                            skipButtonShown = false;
                            _pageController.jumpToPage(
                              _pagesList.length - 1,
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              Languages.of(context).interiorSkip,
                              style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_nineteen')),
                            ),
                            Icon(
                              LanguageState.language == Language.en? FeatherIcons.chevronRight : FeatherIcons.chevronLeft,
                              color: AppTheme.colorBox('meeting_color_nineteen'),
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
