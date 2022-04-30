import 'dart:io';

import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meeting_management/logic/meeting/repository/meetting_api_repository.dart';
import 'package:meeting_management/logic/person/bloc/person_bloc.dart';
import 'package:meeting_management/logic/person/repository/person_api_repository.dart';
import 'package:meeting_management/screen/authenticate/bloc/authenticate_bloc.dart';
import 'package:meeting_management/screen/authenticate/widgets/sign_up/register.dart';
import 'package:meeting_management/screen/base_screen.dart';
import 'package:meeting_management/screen/interior/interior_screen.dart';
import 'package:meeting_management/screen/splash/splash_screen.dart';
import 'package:meeting_management/theme/bloc/theme_bloc.dart';
import 'package:meeting_management/theme/bloc/theme_event.dart';
import 'package:meeting_management/theme/bloc/theme_state.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/people_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/unit_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/repository/people_group_repository.dart';
import 'package:meeting_management/logic/member/repository/member_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/repository/todo_reository.dart';
import 'package:meeting_management/widget/notes/repository/note_reository.dart';
import 'package:meeting_management/widget/notification/model/notification_data.dart';
import 'package:meeting_management/widget/notification/repository/notification_repository.dart';
import 'package:meeting_management/widget/share_widget/scroll_behavior.dart';
import "package:universal_html/html.dart" as html;

import 'fire_base/fire_base.dart';
import 'fire_base/firebase_config.dart';
import 'language/bloc/language_bloc.dart';
import 'language/bloc/language_event.dart';
import 'language/bloc/language_state.dart';
import 'language/languages/languages.dart';
import 'logic/location/repository/location_repository.dart';
import 'screen/authenticate/repository/authenticate_repository.dart';
import 'screen/authenticate/widgets/login/sign_in.dart';
import 'package:flutter/foundation.dart';

class Routes {
  static const String SplashScreen = "/";
  static const String InteriorScreen = "/interior_screen";
  static const String BaseScreen = "/base_screen";
  static const String SignInScreen = "/sign_in_screen";
  static const String SignUpScreen = "/sign_up_screen";
}

final routes = <String, WidgetBuilder>{
  Routes.SplashScreen: (BuildContext context) => const SplashScreen(),
  Routes.InteriorScreen: (BuildContext context) => const InteriorScreen(),
  Routes.BaseScreen: (BuildContext context) => const BaseScreen(),
  Routes.SignInScreen: (BuildContext context) => const Material(child: SignIn()),
  Routes.SignUpScreen: (BuildContext context) => const Material(child: Register()),
  // MultiBlocProvider(
  //   providers: [
  //     BlocProvider(create: (context) => LoginBloc(context.read<AuthApiRepository>())),
  //     BlocProvider(create: (context) => NoteBloc(context.read<NoteRepository>())),
  //   ],
  //   child:
  //   const BaseScreen(),
  // ),
};

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseConfig.platformOptions);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  HttpOverrides.global = MyHttpOverrides();
  await Hive.initFlutter();
  Hive.registerAdapter<NotificationDataModel>(NotificationDataModelAdapter());
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (BuildContext context) => AuthenticateApiRepository()),
        RepositoryProvider(create: (BuildContext context) => PersonApiRepository()),
        RepositoryProvider(create: (BuildContext context) => NoteRepository()),
        RepositoryProvider(create: (BuildContext context) => TodoRepository()),
        RepositoryProvider(create: (BuildContext context) => PeopleRepository()),
        RepositoryProvider(create: (BuildContext context) => UnitRepository()),
        RepositoryProvider(create: (BuildContext context) => AssetsRepository()),
        RepositoryProvider(create: (BuildContext context) => LocationRepository()),
        RepositoryProvider(create: (BuildContext context) => PeopleGroupRepository()),
        RepositoryProvider(create: (BuildContext context) => MemberRepository()),
        RepositoryProvider(create: (BuildContext context) => MeetingApiRepository()),
        RepositoryProvider(create: (BuildContext context) => NotificationRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => LanguageBloc()),
          // BlocProvider(create: (context) => LoginBloc(context.read<AuthApiRepository>())),
          BlocProvider(create: (context) => PersonBloc(context.read<PersonApiRepository>())),
          BlocProvider(create: (context) => AuthenticateBloc(context.read<AuthenticateApiRepository>())),

        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {

    if (PlatformInfo().isWeb()) {
      if (html.document.getElementById('splash') != null) {
        html.document.getElementById('splash')!.remove();
      }
    }

    context.read<LanguageBloc>().add(LoadLanguageEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (BuildContext context, LanguageState languageState) {
        context.read<ThemeBloc>().add(LoadThemeEvent());
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (BuildContext context, ThemeState themeState) {
            return MaterialApp(
              scrollBehavior: AppScrollBehavior(),
              locale: languageState.locale,
              title: 'Meeting Management',
              localizationsDelegates: const [AppLocalizationsDelegate(), GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
              supportedLocales: const [
                Locale('en', 'US'), // English, no country code
                Locale('fa', 'IR'), // Persian, no country code
              ],
              debugShowCheckedModeBanner: false,
              theme: themeState.themeData,
              initialRoute: Routes.SplashScreen,
              routes: routes,
              // home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}
