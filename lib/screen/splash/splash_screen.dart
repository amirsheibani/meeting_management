import 'dart:async';

import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/local_storage.dart';
import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/main.dart';
import 'package:meeting_management/theme/bloc/theme_bloc.dart';
import 'package:meeting_management/theme/bloc/theme_event.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/share_widget/change_language.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with WidgetsBindingObserver {
  List<Widget> _widgetList = [];
  double _showing1 = 0;
  double _showing2 = 0;
  late Timer _timer1;
  late Timer _timer2;

  // String? _currentSelectedValue;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    context.read<ThemeBloc>().add(LoadThemeEvent());
    // _currentSelectedValue = LanguageState.language == Language.en ? _languagesList[0] : _languagesList[1];
    _timer1 = Timer(const Duration(milliseconds: 1000), () {
      _timer1.cancel();
      setState(() {
        _showing1 = 1;
      });
      _timer2 = Timer(const Duration(milliseconds: 1500), () {
        _timer2.cancel();
        setState(() {
          _showing2 = 1;
        });
      });
    });

    super.initState();
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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        _widgetList = [
          Text(
            Languages.of(context).splashTitleOne,
            style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
            textAlign: constraints.maxWidth > constraints.maxHeight ? TextAlign.start : TextAlign.center,
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: _showing1,
            child: Text(
              Languages.of(context).splashTitleTwo,
              style: Theme.of(context).textTheme.headline2!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
              textAlign: constraints.maxWidth > constraints.maxHeight ? TextAlign.start : TextAlign.center,
            ),
          ),
          Text(
            Languages.of(context).splashProvidedBy,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
            textAlign: constraints.maxWidth > constraints.maxHeight ? TextAlign.start : TextAlign.center,
          ),
          Text(
            Languages.of(context).splashCopyRight,
            style: Theme.of(context).textTheme.subtitle2!.copyWith(fontWeight: FontWeight.w300, color: AppTheme.colorBox('meeting_color_four')),
            textAlign: constraints.maxWidth > constraints.maxHeight ? TextAlign.start : TextAlign.center,
          ),
          Image.asset(
            'assets/images/login.png',
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 1000),
            opacity: _showing2,
            child: SizedBox(
              width: 300,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  Map<String, String> interiorScreenStatus = await LocalStorage.instance.readString(interiorScreen, session: false);
                  if (interiorScreenStatus[interiorScreen] == null) {
                    await LocalStorage.instance.saveString({
                      interiorScreen: interiorScreenTrue,
                    }, session: false);
                    Navigator.pushNamedAndRemoveUntil(context, Routes.InteriorScreen, (route) => false);
                  } else {
                    if (interiorScreenStatus[interiorScreen]!.replaceAll(' ', '') == interiorScreenTrue) {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.BaseScreen, (route) => false);
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const BaseScreen()));
                    } else {
                      await LocalStorage.instance.saveString({interiorScreen: interiorScreenTrue}, session: false);
                      Navigator.pushNamedAndRemoveUntil(context, Routes.InteriorScreen, (route) => false);
                    }
                  }
                  // Navigator.pushNamedAndRemoveUntil(context, Routes.InteriorScreen, (route) => false);
                },
                child: Text(
                  Languages.of(context).meetingGetStart,
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  alignment: Alignment.center,
                  backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meetings_color_three')),
                ),
              ),
            ),
          )
        ];
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(color: AppTheme.colorBox('meeting_color_eighteen')
              // gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [AppTheme.colorBox('meeting_color_sixteen')!, AppTheme.colorBox('meeting_color_seven')!]),
              ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ChangeLanguage(),
                ),
                Padding(
                  padding: constraints.maxWidth > 740 ? const EdgeInsets.fromLTRB(100, 0, 100, 20) : const EdgeInsets.fromLTRB(40, 0, 40, 20),
                  child: constraints.maxWidth > 600
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 3,
                              child: SizedBox(
                                height: constraints.maxHeight - 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Spacer(),
                                    _widgetList[0],
                                    _widgetList[1],
                                    const SizedBox(
                                      height: 60,
                                    ),
                                    _widgetList[5],
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                height: constraints.maxHeight - 80,
                                child: Column(
                                  children: [
                                    _widgetList[4],
                                    const Spacer(),
                                    AnimatedOpacity(
                                      duration: const Duration(milliseconds: 1000),
                                      opacity: _showing1,
                                      child: Column(
                                        children: [
                                          _widgetList[2],
                                          _widgetList[3],
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: constraints.maxHeight - 60,
                          child: Column(
                            children: [
                              _widgetList[0],
                              _widgetList[1],
                              SizedBox(height: constraints.maxHeight / 3, child: _widgetList[4]),
                              const SizedBox(
                                height: 20,
                              ),
                              _widgetList[5],
                              const SizedBox(
                                height: 20,
                              ),
                              const Spacer(),
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 1000),
                                opacity: _showing1,
                                child: Column(
                                  children: [
                                    _widgetList[2],
                                    _widgetList[3],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
