import 'package:flutter/material.dart';
import 'language_en.dart';
import 'language_fa.dart';

abstract class Languages {
  static Languages of(BuildContext context) => Localizations.of<Languages>(context, Languages)!;
  String get theme;
  String get softwareVersion;
  String get selectTheme;
  String get manual;
  String get system;
  String get themeDark;
  String get themeLight;
  String get notification;
  String get language;
  String get settings;
  String get date;
  String get time;
  String get location;
  String get members;
  String get subject;
  String get assets;
  String get agenda;


  String get english;
  String get persian;

  String get save;
  String get cancel;
  String get ok;
  String get close;
  String get successful;
  String get empty;
  String get fileExport;
  String get fileShare;
  String get details;
  String get title;
  String get description;
  String get remove;
  String get show;
  String get add;
  String get name;
  String get code;
  String get low;
  String get medium;
  String get high;

  String get lastname;
  String get firstname;
  String get mobile;
  String get email;
  String get phone;
  String get address;
  String get unit;
  String get latitude;
  String get longitude;

  String get male;
  String get female;

  String get appName;
  String get pleaseWait;
  String get snackbarWarning;
  String get snackbarError;
  String get snackbarInfo;
  String get snackbarOkButton;
  String get snackbarCancelButton;

//meeting

  String get meetingButtonSkip;
  String get meetingButtonPrev;
  String get meetingButtonNext;
  String get meetingButtonSave;
  String get meetingButtonUpdate;
  String get meetingButtonOk;
  String get meetingButtonCancel;
  String get meetingButtonSend;
  String get meetingButtonAttach;
  String get meetingButtonRemove;

  String get meetingMessageTo;
  String get meetingMessageSubject;

  String get meetingWidgetNextMeetingTooltipMessage;
  String get meetingWidgetPrevMeetingTooltipMessage;
  String get meetingCalenderCurrentDay;
  String get meetingCalenderNextMonth;
  String get meetingCalenderPrevMonth;
  String get meetingMinCalenderMaximumSizeTooltipMessage;
  String get meetingCalenderNextMonthTooltipMessage;
  String get meetingCalenderPrevMonthTooltipMessage;
  String get meetingCalenderCurrentDayTooltipMessage;
  String get meetingMaxCalenderDismissTooltipMessage;
  String get meetingCalenderAddNewMeeting;

  String get meetingSplashScreenTitle;

  String get meetingMorePageTitle;
  String get meetingMorePageDescription;

  String get meetingLogOutButton;
  String get meetingLogInButton;
  String get meetingRegisterButton;

  String get meetingManualSelectTheme;

  String get meetingNotesTitle;
  String get meetingNotesSubText;
  String get meetingNotesAddNew;

  String get meetingMessageTitle;
  String get meetingMessageSubText;
  String get meetingMessageAddNew;

  String get meetingTodoListTitle;
  String get meetingTodoListSubText;
  String get meetingTodoNew;

  String get meetingInvitation;
  String get meetingInvitationDescription;
  String get setMeeting;
  String get meetingAcceptInvitation;
  String get meetingDenyInvitation;
  String get meetingDelayedInvitation;
  String get meetingDetailTitle;
  String get meetingAgendaDownload;

  String get meetingsTitle;
  String get meetingMember;
  String get meetingCanceled;
  String get meetingReminder;
  String get meetingTimePM;
  String get meetingTimeAM;
  String get meetingSetMeetingTitle;

  String get meetingPeople;
  String get meetingPeopleGroup;
  String get meetingLocation;
  String get meetingAssets;

  String get meetingSelectLocation;
  String get meetingAddFiles;
  String get meetingUnNamedFile;
  String get meetingSignInTitle;
  String get meetingSignIn;
  String get meetingSignUp;
  String get meetingOR;
  String get meetingSignInWith;
  String get meetingGetStart;
  String get meetingForgotPass;
  String get meetingRememberMe;
  String get meetingUserName;
  String get meetingPassword;
  String get meetingRetryPassword;
  String get meetingSelectGender;

  String get meetingEmptyValidator;
  String get meetingNameErrorText;
  String get meetingEmailErrorText;
  String get meetingMobileNumberErrorText;
  String get meetingPasswordErrorText;
  String get checkWorkEmail;

  String get dropdownMustSelectOneOption;

  String get splashTitleOne;
  String get splashTitleTwo;
  String get splashProvidedBy;
  String get splashCopyRight;

  String get interiorSetAlarm;
  String get interiorMakeTodoList;
  String get interiorCheckEmail;
  String get interiorSaveNote;
  String get interiorSetMeeting;
  String get interiorHaveAll;
  String get interiorSkip;
  String get interiorLetDo;




}

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fa'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'fa':
        return LanguageFa();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

