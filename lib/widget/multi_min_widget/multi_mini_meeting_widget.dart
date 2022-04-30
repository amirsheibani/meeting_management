import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/meeting_mini_hourly/meeting_mini_hourly_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/metting_mini_daily/metting_mini_daily_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/bloc/todo_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/repository/todo_reository.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/todo_list_min.dart';


class MultiMiniMeetingWidget extends StatefulWidget {
  const MultiMiniMeetingWidget({Key? key}) : super(key: key);

  @override
  _MultiMiniMeetingWidgetState createState() => _MultiMiniMeetingWidgetState();
}

class _MultiMiniMeetingWidgetState extends State<MultiMiniMeetingWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Column(
            children: [
              Expanded(
                child: Row(
                  children: const [
                    Expanded(
                      child: MeetingMinDaily(),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                        child: MeetingMinHourly()
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                child: BlocProvider(
                  create: (context) => TodoBloc(context.read<TodoRepository>()),
                  child: TodoListMin(onTap: () {}),
                ),
              ),
            ],
          );
        }
    );
  }
}
