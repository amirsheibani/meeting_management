import 'package:behpardaz_flutter_custom_utility/tools/utility/utility.dart';
import 'package:behpardaz_flutter_custom_widget/tools/custom_widget/custom_snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/bloc/language_bloc.dart';
import 'package:meeting_management/language/bloc/language_event.dart';
import 'package:meeting_management/language/bloc/language_state.dart';
import 'package:meeting_management/logic/person/bloc/person_bloc.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/bloc/theme_bloc.dart';
import 'package:meeting_management/theme/bloc/theme_event.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/share_widget/change_language.dart';
import 'package:meeting_management/widget/notification/bloc/notification_bloc.dart';
import 'package:meeting_management/widget/notification/repository/notification_repository.dart';


import 'dashboard/meeting_home_screen.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<BottomNavigationBarItem> _bottomNavigationBarItems = [];
  int _selectedIndex = 0;

  String? _token;
  late Stream<String> _tokenStream;

  @override
  void initState() {
    context.read<PersonBloc>().add(const GetPersonData());
    context.read<ThemeBloc>().add(LoadThemeEvent());
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen((token) {
      debugPrint('fcm token is refreshed: $token');
      _token = token;
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
    bool isMobile = MediaQuery
        .of(context)
        .size
        .width < 740;
    _bottomNavigationBarItems.clear();
    _bottomNavigationBarItems.add(const BottomNavigationBarItem(activeIcon: Icon(FeatherIcons.home), icon: Icon(FeatherIcons.home), label: 'Home', backgroundColor: Colors.transparent));
    _bottomNavigationBarItems.add(const BottomNavigationBarItem(activeIcon: Icon(FeatherIcons.settings), icon: Icon(FeatherIcons.home), label: 'Home', backgroundColor: Colors.transparent));
    return Scaffold(
      bottomNavigationBar: !isMobile
          ? null
          : BottomNavigationBar(
        iconSize: 32,
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
            if (value == 0) {
              // context.read<MenuSideItemBloc>().add(MenuSideItemSelectEvent(MenuSideItemStatus.home));
            } else if (value == 1) {
              // context.read<MenuSideItemBloc>().add(MenuSideItemSelectEvent(MenuSideItemStatus.portfolio));
            }
          });
        },
        items: _bottomNavigationBarItems,
      ),
      body: Center(
        child: BlocConsumer<PersonBloc, PersonState>(
          listener: (context, state) {
            if (state is PersonDataFailed) {
              debugPrint('${(state).props[0]!}');
              // _showExceptionMessage((state).props[0]!);
            }
          },
          builder: (context, state) {
            if (state is PersonDataSuccess) {
              return BlocProvider(
                create: (context) => NotificationBloc(context.read<NotificationRepository>()),
                child: MeetingHomeScreen(
                  scaffoldKey: _scaffoldKey,
                  person: state.props[1]! as Person,
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }

  _showExceptionMessage(Exception exception) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.colorBox('snack_bar_error_background_color'),
        content: ErrorSnackBar(
          height: 200,
          title: exception.runtimeType.toString(),
          message: exception.toString(),
          ok: () {
            ScaffoldMessenger.of(_scaffoldKey.currentContext!).hideCurrentSnackBar();
          },
          cancel: () {},
          // color: AppTheme.colorBox('snack_bar_error_color'),
        ),
        duration: const Duration(minutes: 3),
      ),
    );
  }
}
