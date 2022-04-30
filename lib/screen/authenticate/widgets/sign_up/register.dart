import 'package:behpardaz_flutter_custom_utility/behpardaz_flutter_custom_utility.dart';
import 'package:flutter/material.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/drop_down/gender/widget/gender_dropdown_widget.dart';
import 'package:meeting_management/widget/share_widget/text_field.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/validation.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _retryPasswordController = TextEditingController();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _retryPasswordFocusNode = FocusNode();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PlatformInfo().isWeb()? null: AppBar(),
      body:
      LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return
              Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  color: AppTheme.colorBox('meeting_color_eighteen')
                // gradient: LinearGradient(
                //     begin: Alignment.centerLeft,
                //     end: Alignment.centerRight,
                //     colors: [
                //       AppTheme.colorBox('meeting_color_sixteen')!,
                //       AppTheme.colorBox('meeting_color_seven')!
                //     ]),
              ),
              child:  Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment:constraints.maxWidth>constraints.maxHeight? CrossAxisAlignment.start : CrossAxisAlignment.center,
                        children: [
                          if(constraints.maxWidth>constraints.maxHeight)
                          const Spacer(flex: 1,),
                           Expanded(
                             flex: 4,
                             child: Center(
                               child: Form(
                                 child: GridView.count(
                                          primary: false,
                                          childAspectRatio: constraints.maxWidth > constraints.maxHeight?(constraints.maxWidth/2)/170:(constraints.maxWidth)/100,
                                          shrinkWrap: true,
                                          crossAxisCount: constraints.maxWidth > constraints.maxHeight ?2:1,
                                          crossAxisSpacing: 16,
                                          mainAxisSpacing: 0,
                                          children: [
                                            FormTextField(
                                              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
                                              keyboardType: TextInputType.text,
                                              focusNode: _firstNameFocusNode,
                                              obscureText: false,
                                              controller: _firstNameController,
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).firstname,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight')),
                                              validations: [
                                                (String? value){
                                                if(value!.isNotNullValidation){
                                                  return null;
                                                }
                                                return Languages.of(context).meetingEmptyValidator;

                                                },

                                                (String? value){
                                                if(value!.isNotName){
                                                  return Languages.of(context).meetingNameErrorText;
                                                }
                                                return null;

                                              }
                                              ],
                                            ),
                                            FormTextField(
                                              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
                                              keyboardType: TextInputType.text,
                                              focusNode: _lastNameFocusNode,
                                              obscureText: false,
                                              controller: _lastNameController,
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).lastname,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
                                              validations: [
                                                    (String? value){
                                                  if(value!.isNotNullValidation){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmptyValidator;

                                                },

                                                    (String? value){
                                                  if(value!.isNotName){
                                                    return Languages.of(context).meetingNameErrorText;
                                                  }
                                                  return null;

                                                }
                                              ],
                                            ),
                                            FormTextField(
                                              textFieldAlignment: TextDirection.ltr,
                                              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
                                              keyboardType: TextInputType.emailAddress,
                                              focusNode: _emailFocusNode,
                                              obscureText: false,
                                              controller: _emailController,
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).email,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
                                              validations: [
                                                    (String? value){
                                                  if(value!.isNotNullValidation){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmptyValidator;

                                                },
                                                    (String? value){
                                                  if(value!.isEmail){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmailErrorText;

                                                },
                                                    (String? value) {
                                                  if (_emailController.text.toLowerCase().contains('@gmail') || _emailController.text.contains('@yahoo') || _emailController.text.contains('@hotmail') || _emailController.text.contains('@live')){
                                                    return Languages.of(context).checkWorkEmail;
                                                  }
                                                  return null;
                                                },
                                              ],


                                            ),
                                            FormTextField(
                                              textFieldAlignment: TextDirection.ltr,
                                              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
                                              keyboardType: TextInputType.text,
                                              focusNode: _mobileFocusNode,
                                              obscureText: false,
                                              controller: _mobileController,
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).mobile,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
                                              validations: [
                                                    (String? value){
                                                  if(value!.isNotNullValidation){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmptyValidator;

                                                },
                                                    (String? value){
                                                  if(value!.isMobileNumber){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingMobileNumberErrorText;

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
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).meetingPassword,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
                                              validations: [
                                                    (String? value){
                                                  if(value!.isNotNullValidation){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmptyValidator;

                                                },

                                                    (String? value){
                                                      if(!value!.isPassword){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingPasswordErrorText;

                                                },
                                              ],

                                            ),
                                            FormTextField(
                                              textFieldAlignment: TextDirection.ltr,
                                              errorStyle: Theme.of(context).textTheme.subtitle2!.copyWith(color: AppTheme.colorBox('meeting_color_seventeen')),
                                              keyboardType: TextInputType.visiblePassword,
                                              focusNode: _retryPasswordFocusNode,
                                              obscureText: true,
                                              visibilityIconColor: AppTheme.colorBox('meeting_color_four'),
                                              controller: _retryPasswordController,
                                              onFieldSubmittedFunction: (String value) {  },
                                              cursorColor: AppTheme.colorBox('meeting_color_four'),
                                              hintTitle: Languages.of(context).meetingRetryPassword,
                                              hintTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four'), fontWeight: FontWeight.w400),
                                              focusedBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              enabledBorderColor: AppTheme.colorBox('meeting_color_four'),
                                              errorBorderColor: AppTheme.colorBox('meeting_color_ten'),
                                              textFieldTextStyle:Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_four')),
                                              validations: [
                                                    (String? value){
                                                  if(value!.isNotNullValidation){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingEmptyValidator;

                                                },

                                                    (String? value){
                                                  if(!value!.isPassword){
                                                    return null;
                                                  }
                                                  return Languages.of(context).meetingPasswordErrorText;

                                                },
                                              ],
                                            ),
                                            GenderDropdownWidget(change: (value){}, validations: [],),
                                          ],
                                        ),
                               ),
                             ),
                           ),
                          const SizedBox(height: 20,),
                          SizedBox(
                            width: 200,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                              },
                              child: Text(
                                Languages.of(context).meetingSignUp,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline3!
                                    .copyWith(
                                    color:
                                    AppTheme.colorBox('meeting_color_eight'),
                                    fontWeight: FontWeight.w300,
                                    height: 1),
                              ),
                              style: ButtonStyle(
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                alignment: Alignment.center,
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    AppTheme.colorBox('meetings_color_three')),
                              ),
                            ),
                          ),
                          if(constraints.maxWidth>constraints.maxHeight)
                            const Spacer(),
                        ],
                      ),
                    ),
                    if(constraints.maxWidth>constraints.maxHeight)
                    const SizedBox(
                      width: 20,
                    ),
                    if(constraints.maxWidth>constraints.maxHeight)
                      Expanded(
                      flex: 2,
                      child: Image.asset(
                        'assets/images/login.png',
                      ),
                    ),
                  ],
                ),
              )
            );
          },
  ),
    );
  }
}
