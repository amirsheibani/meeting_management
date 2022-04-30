import 'package:behpardaz_flutter_custom_widget/tools/custom_widget/custom_snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/main.dart';
import 'package:meeting_management/screen/authenticate/bloc/authenticate_bloc.dart';
import 'package:meeting_management/screen/authenticate/bloc/authenticate_event.dart';
import 'package:meeting_management/screen/authenticate/bloc/authenticate_state.dart';
import 'package:meeting_management/widget/share_widget/text_field.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/validation.dart';

import 'remember_me.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<Widget> widgetList = [];
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _userNameNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        widgetList = [
          FormTextField(
            textFieldAlignment: TextDirection.ltr,
            errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
            keyboardType: TextInputType.emailAddress,
            focusNode: _userNameNameFocusNode,
            obscureText: false,
            controller: _userNameController,
            onFieldSubmittedFunction: (String value) {},
            cursorColor: AppTheme.colorBox('meeting_color_four'),
            hintTitle: Languages.of(context).meetingUserName,
            hintTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
            focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
            enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
            errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
            textFieldTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
            validations: [
              (String? value) {
                if (value!.isNotNullValidation) {
                  return null;
                }
                return Languages.of(context).meetingEmptyValidator;
              },
              (String? value) {
                if (value!.isEmail) {
                  return null;
                }
                return Languages.of(context).meetingEmailErrorText;
              },
              (String? value) {
                if (_userNameController.text.toLowerCase().contains('@gmail') ||
                    _userNameController.text.contains('@yahoo') ||
                    _userNameController.text.contains('@hotmail') ||
                    _userNameController.text.contains('@live')) {
                  return Languages.of(context).checkWorkEmail;
                }
                return null;
              },
            ],
          ),
          FormTextField(
            textFieldAlignment: TextDirection.ltr,
            errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
            keyboardType: TextInputType.visiblePassword,
            focusNode: _passwordFocusNode,
            obscureText: true,
            visibilityIconColor: AppTheme.colorBox('meeting_color_four'),
            controller: _passwordController,
            onFieldSubmittedFunction: (String value) {},
            cursorColor: AppTheme.colorBox('meeting_color_four'),
            hintTitle: Languages.of(context).meetingPassword,
            hintTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
            focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
            enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
            errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
            textFieldTextStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
            validations: [
              (String? value) {
                if (value!.isNotNullValidation) {
                  return null;
                }
                return Languages.of(context).meetingEmptyValidator;
              },
              (String? value) {
                if (!value!.isPassword) {
                  return null;
                }
                return Languages.of(context).meetingPasswordErrorText;
              },
            ],
          ),
          TextButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
            ),
            onPressed: () {},
            child: Text(
              Languages.of(context).meetingForgotPass,
              style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
            ),
          ),
          RememberMe(
            text: Languages.of(context).meetingRememberMe,
            textStyle: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
            iconColor: AppTheme.colorBox('meeting_color_four'),
            onChange: (value) {
              print(value);
            },
          ),
          SizedBox(
            width: 223,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  context.read<AuthenticateBloc>().add(LogInEvent(_userNameController.text, _passwordController.text,));
                }
                // context.read<AuthenticateBloc>().add(LogInEvent(_userNameController.text, _passwordController.text,));
              },
              child: Text(
                Languages.of(context).meetingSignIn,
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
          Image.asset(
            'assets/images/login.png',
          ),
        ];
        return BlocListener<AuthenticateBloc, AuthenticateState>(
          listener: (context, state) {
            if (state is AuthenticateSuccess) {
              Navigator.pushReplacementNamed(context, Routes.BaseScreen);
              // Navigator.pushNamedAndRemoveUntil(context, Routes.BaseScreen, (route) => false);

            } else if (state is AuthenticateFailed) {
              debugPrint('login Exception:${state.props[0]}');
              _showExceptionMessage(state.props[0]);
            }
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                color: AppTheme.colorBox('meeting_color_eighteen')
              // gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [AppTheme.colorBox('meeting_color_sixteen')!, AppTheme.colorBox('meeting_color_seven')!]),
            ),
            child: Padding(
              padding: constraints.maxWidth > 740 ? const EdgeInsets.fromLTRB(150, 150, 150, 0) : const EdgeInsets.fromLTRB(40, 40, 40, 0),
              child: constraints.maxWidth > constraints.maxHeight
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                widgetList[0],
                                widgetList[1],
                                widgetList[2],
                                const SizedBox(
                                  height: 10,
                                ),
                                widgetList[3],
                                const SizedBox(
                                  height: 10,
                                ),
                                widgetList[4],
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 3,
                          child: widgetList[5],
                        ),
                      ],
                    )
                  : Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(child: SizedBox(height: 200, child: widgetList[5])),
                          const SizedBox(
                            height: 15,
                          ),
                          widgetList[0],
                          widgetList[1],
                          widgetList[2],
                          widgetList[3],
                          Center(child: widgetList[4])
                        ],
                      ),
                    ),
            ),
          ),
        );
      },),
    );
  }

  _showExceptionMessage(dynamic exception) {
    ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.colorBox('meeting_color_thirteen'),
        content: ErrorSnackBar(
          height: 200,
          title: exception.runtimeType.toString(),
          message: exception.toString(),
          ok: () {
            ScaffoldMessenger.of(_scaffoldKey.currentState!.context).hideCurrentSnackBar();
          },
          cancel: () {},
          // color: AppTheme.colorBox('snack_bar_error_color'),
        ),
        duration: const Duration(minutes: 3),
      ),
    );
  }
}
