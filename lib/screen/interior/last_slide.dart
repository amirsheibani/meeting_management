import 'package:behpardaz_flutter_custom_widget/tools/custom_widget/login_form_divider.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/main.dart';
import 'package:meeting_management/theme/theme.dart';

class LastSlide extends StatefulWidget {
  const LastSlide({Key? key, required this.description, required this.image}) : super(key: key);
  final String description;
  final Widget image;

  @override
  _LastSlideState createState() => _LastSlideState();
}

class _LastSlideState extends State<LastSlide> {
  double showButtons = 0;
  double showLetsDoButton = 1;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      List<Widget> _listWidget = [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: constraints.maxWidth > 600 ? 160 : 0,
            ),
            Text(widget.description, style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meetings_color_one'))),
            if (showLetsDoButton == 1)
              const SizedBox(
                height: 25,
              ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: showLetsDoButton,
              child: SizedBox(
                width: 160,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showButtons = 1;
                      showLetsDoButton = 0;
                    });
                    // Navigator.pushNamedAndRemoveUntil(context, Routes.SignUp, (route) => false);
                  },
                  child: Text(
                    Languages.of(context).interiorLetDo,
                    style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
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
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: showButtons,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, Routes.SignInScreen, (route) => false);
                            },
                            child: Text(
                              Languages.of(context).meetingSignIn,
                              style: Theme.of(context).textTheme.headline3!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300, height: 1),
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
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, Routes.SignUpScreen, (route) => false);
                            },
                            child: Text(
                              Languages.of(context).meetingSignUp,
                              style: Theme.of(context).textTheme.headline3!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300, height: 1),
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
                      ),
                    ],
                  ),
                  FormDivider(
                    title: Languages.of(context).meetingOR,
                    dividerColor: AppTheme.colorBox('meeting_color_four'),
                    titleStyle: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_four')),
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 3,
                        child: SizedBox(
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, Routes.SignInScreen, (route) => false);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    Languages.of(context).meetingSignInWith,
                                    style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300, height: 1),
                                  ),
                                ),
                                Expanded(child: Image.asset('assets/images/logo.png'))
                              ],
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
                      ),
                      const Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: widget.image,
        ),
      ];
      return constraints.maxWidth > 600
          ? Row(
              children: [
                Expanded(child: _listWidget[0]),
                const Spacer(
                  flex: 1,
                ),
                _listWidget[1]
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 250, child: _listWidget[1]),
                const SizedBox(
                  height: 50,
                ),
                _listWidget[0]
              ],
            );
    });
  }
}
