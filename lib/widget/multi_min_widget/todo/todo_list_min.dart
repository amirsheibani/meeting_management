import 'package:behpardaz_flutter_custom_widget/tools/custom_widget/indicator/circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/bloc/todo_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/model/todo_model.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/repository/todo_reository.dart';
import 'package:meeting_management/widget/multi_min_widget/todo/todo_list_item.dart';

import 'show_todo.dart';

class TodoListMin extends StatefulWidget {
  const TodoListMin({Key? key, required this.onTap}) : super(key: key);
  final Function onTap;

  @override
  _TodoListMinState createState() => _TodoListMinState();
}

class _TodoListMinState extends State<TodoListMin> {

  @override
  void initState() {
    context.read<TodoBloc>().add(const RetrieveTodoEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Languages.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
        border: Border.all(width: 1, color: AppTheme.colorBox('meetings_color_one') ?? Colors.black),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  FeatherIcons.list,
                  size: 36,
                  color: AppTheme.colorBox('meetings_color_one') ?? Colors.black,
                ),
                Expanded(
                  child: Text(
                    Languages.of(context).meetingTodoListTitle,
                    style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'),fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  tooltip: Languages.of(context).add,
                  icon: Icon(
                    FeatherIcons.plusCircle,
                    size: 32.0,
                    color: AppTheme.colorBox('meetings_color_one'),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          elevation: 0,
                          backgroundColor: Colors.grey.shade900.withOpacity(0.4),
                          child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                            return DialogFrameWidget(
                              widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.7,
                              heightScale: 0.7,
                              leading: Icon(FeatherIcons.list, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                              title: Text(Languages.of(context).meetingTodoNew, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                              headerColor: AppTheme.colorBox('meeting_color_four'),
                              headerHeight: 80,
                              background: AppTheme.colorBox('meeting_color_eight'),
                              dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                              child: const NewTodoWidget(),
                            );
                          }),
                        );
                      },
                      barrierColor: Colors.transparent,
                    ).then((value) {
                      if(value != null){
                        // debugPrint('todo add ${(value[0] as TodoModel).title}');
                        context.read<TodoBloc>().add(AddTodoEvent(todoModel: value[0] as TodoModel));
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 4.0,
            ),
            Expanded(
              child: BlocListener<TodoBloc, TodoState>(
                listener: (BuildContext context, TodoState state) {
                  if(state is TodoErrorState){
                    debugPrint('todolist Ex:${state.props[0]}');
                  }else if(state is NewTodoLoadedState || state is UpdateTodoLoadedState || state is CompleteTodoLoadedState){
                    context.read<TodoBloc>().add(const RetrieveTodoEvent());
                  }
                },
                child: BlocBuilder<TodoBloc, TodoState>(
                  builder: (BuildContext context, TodoState state) {
                    if (state is RetrieveTodoLoadedState) {
                      List<TodoModel> _list = state.todos;
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              TextStyle? _textStyle;
                              if (_list[index].done!) {
                                _textStyle = Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black, fontWeight: FontWeight.w500, decorationColor: AppTheme.colorBox('meeting_color_ten'), decoration: TextDecoration.lineThrough);
                              } else {
                                _textStyle = Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.black, fontWeight: FontWeight.w500);
                              }
                              Icon _icon = Icon(
                                _list[index].done! ? FeatherIcons.checkCircle : FeatherIcons.circle,
                                size: 16,
                                color: Colors.black,
                              );
                              return TodoListItem(
                                onTap: () {
                                  context.read<TodoBloc>().add(CompleteTodoEvent(id: _list[index].id!, done: !_list[index].done!));
                                },
                                onTapEdit: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        elevation: 0,
                                        backgroundColor: Colors.grey.shade900.withOpacity(0.4),
                                        child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                          return DialogFrameWidget(
                                            widthScale: MediaQuery.of(context).size.width < 740 ? 1 : 0.7,
                                            heightScale: 0.7,
                                            leading: Icon(FeatherIcons.list, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                            title: Text(Languages.of(context).meetingTodoNew, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                            headerColor: AppTheme.colorBox('meeting_color_four'),
                                            headerHeight: 80,
                                            background: AppTheme.colorBox('meeting_color_eight'),
                                            dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                            child: NewTodoWidget(
                                              todoModel: _list[index],
                                            ),
                                          );
                                        }),
                                      );
                                    },
                                    barrierColor: Colors.transparent,
                                  ).then((value) {
                                    if (value != null) {
                                      context.read<TodoBloc>().add(UpdateTodoEvent(todoModel: value[0]));
                                    }
                                  });
                                },
                                title: _list[index].title,
                                titleStyle: _textStyle,
                                icon: _icon,
                                done: _list[index].done,
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox();
                            },
                            itemCount: _list.length),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meetings_color_three'),strokeWidth: 1.5));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
