import 'package:behpardaz_flutter_custom_widget/tools/custom_widget/custom_snack_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/notification/repository/notification_repository.dart';

import 'bloc/notification_bloc.dart';
import 'model/notification_data.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  _NotificationWidgetState createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  void initState() {

    context.read<NotificationBloc>().add(const RetrieveNotificationEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationErrorState) {
          debugPrint('notification Exception:${state.props[0]}');
          _showExceptionMessage(state.props[0]);
        }else if (state is AddNotificationState || state is UpdateNotificationState || state is RemoveNotificationState) {
          debugPrint('notification resive');
          context.read<NotificationBloc>().add(const RetrieveNotificationEvent());
        }
      },
      builder: (context, state) {
        if (state is RetrieveNotificationState) {
          List<NotificationDataModel> notificationItems = state.props[0];
          return PopupMenuButton(
            tooltip: Languages.of(context).notification,
            // padding: EdgeInsets.only(top: 8,bottom: 8),meeting_color_eleven
            color: AppTheme.colorBox('meeting_color_eleven'),
            offset: const Offset(0.0, 48.0),
            elevation: 0,
            initialValue: notificationItems.length,
            itemBuilder: (BuildContext context) {
              return state.notificationItems.map(
                    (item) {
                  return PopupMenuItem(
                    padding: const EdgeInsets.all(0),
                    onTap: () {
                      item.status = true;
                      context.read<NotificationBloc>().add(UpdateNotificationEvent(item));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
                          border: Border.all(width: 1, color: AppTheme.colorBox('meetings_color_one') ?? Colors.black),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 4,
                          leading: item.status! ? const Icon(Icons.notifications_none, size: 24, color: Colors.red) : const Icon(Icons.notifications, size: 24, color: Colors.red),
                          title: Text(
                            item.title ?? '',
                            style: Theme.of(context).textTheme.headline4!.apply(color: Colors.black),
                          ),
                          subtitle: Text(
                            item.subTitle ?? '',
                            style: Theme.of(context).textTheme.subtitle1!.apply(color: Colors.black),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              context.read<NotificationBloc>().add(RemoveNotificationPopEvent(item));
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.remove_circle_outline, size: 24, color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList();
              // PopupMenuItem(child: Container);
            },
            child: Center(
              child: SizedBox(
                width: 32.0,
                height: 32.0,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    double iconSize = 32;
                    double counterSize = 16;
                    return InkWell(
                      child: Stack(
                        children: [
                          Center(
                              child: Icon(
                                Icons.notifications,
                                size: iconSize,
                                color: AppTheme.colorBox('meeting_color_four'),
                              )),
                          if (notificationItems.where((element) => element.status == false).toList().isNotEmpty)
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: counterSize,
                                height: counterSize,
                                decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                child: FittedBox(
                                  fit: constraints.maxWidth < constraints.maxHeight ? BoxFit.fitWidth :BoxFit.fitHeight,
                                  child: Text('${notificationItems.where((element) => element.status == false).toList().length}'.convertNumberWithLanguage(),style: const TextStyle(fontWeight: FontWeight.w300, color: Colors.white,),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
        return Icon(Icons.notifications, color: AppTheme.colorBox('meeting_color_four'), size: 32);
      },
    );
  }

  _showExceptionMessage(dynamic exception) {
    ScaffoldMessenger.of(widget.scaffoldKey.currentState!.context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.colorBox('meeting_color_thirteen'),
        content: ErrorSnackBar(
          height: 200,
          title: exception.runtimeType.toString(),
          message: exception.toString(),
          ok: () {
            ScaffoldMessenger.of(widget.scaffoldKey.currentState!.context).hideCurrentSnackBar();
          },
          cancel: () {},
          // color: AppTheme.colorBox('snack_bar_error_color'),
        ),
        duration: const Duration(minutes: 3),
      ),
    );
  }
}
