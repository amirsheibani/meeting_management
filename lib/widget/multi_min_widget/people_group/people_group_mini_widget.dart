import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';

import 'bloc/people_group/people_group_bloc.dart';
import 'model/group_type_model.dart';
import 'people_group_add_widget.dart';
import 'people_group_widget.dart';
import 'repository/people_group_repository.dart';

class PeopleGroupMiniWidget extends StatefulWidget {
  const PeopleGroupMiniWidget({Key? key, required this.person}) : super(key: key);
  final Person person;

  @override
  _PeopleGroupMiniWidgetState createState() => _PeopleGroupMiniWidgetState();
}

class _PeopleGroupMiniWidgetState extends State<PeopleGroupMiniWidget> {
  List<PeopleGroupModel>? _peopleGroupModels;
  List<GroupTypeModel>? _groupTypeModels;

  @override
  void initState() {
    context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
    context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupTypeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FeatherIcons.users,
                    size: 36,
                    color: AppTheme.colorBox('meetings_color_one') ?? Colors.black,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Text(
                      Languages.of(context).meetingPeopleGroup,
                      style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20, color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                    ),
                  ),
                  BlocListener<PeopleGroupBloc, PeopleGroupState>(
                    listener: (context, state) {
                      if (state is PeopleGroupErrorState) {
                        debugPrint('PeopleGroup list Ex:${state.props[0]}');
                      }
                    },
                    child: BlocBuilder<PeopleGroupBloc, PeopleGroupState>(
                      builder: (context, PeopleGroupState state) {
                        if (state is RetrievePeopleGroupTypeLoadedState) {
                          _groupTypeModels = (state).props[0]!;
                        }
                        if (_groupTypeModels != null) {
                          return IconButton(
                            padding: const EdgeInsets.all(0.0),
                            tooltip: Languages.of(context).add,
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
                                      return Material(
                                        child: DialogFrameWidget(
                                          widthScale: MediaQuery.of(context).size.width < 1110 ? 1 : 0.6,
                                          heightScale: 1,
                                          leading: Icon(FeatherIcons.users, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                          title: Text(Languages.of(context).add, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                          headerColor: AppTheme.colorBox('meeting_color_four'),
                                          headerHeight: 80,
                                          background: AppTheme.colorBox('meeting_color_eight'),
                                          dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                          child: BlocProvider(
                                            create: (context) => PeopleGroupBloc(context.read<PeopleGroupRepository>()),
                                            child: PeopleGroupAddWidget(
                                              groupTypeModel: _groupTypeModels!.last,
                                              person: widget.person,
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                                  );
                                },
                                barrierColor: Colors.transparent,
                              ).then((value) {
                                context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
                              });
                            },
                            icon: Icon(
                              FeatherIcons.plusCircle,
                              size: 36,
                              color: AppTheme.colorBox('meetings_color_one') ?? Colors.black,
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    iconSize: 18,
                    tooltip: Languages.of(context).meetingMinCalenderMaximumSizeTooltipMessage,
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
                              return Material(
                                child: DialogFrameWidget(
                                  widthScale: MediaQuery.of(context).size.width < 1110 ? 1 : 0.6,
                                  heightScale: 1,
                                  leading: Icon(FeatherIcons.users, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                  title: Text(Languages.of(context).meetingPeopleGroup, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                  headerColor: AppTheme.colorBox('meeting_color_four'),
                                  headerHeight: 80,
                                  background: AppTheme.colorBox('meeting_color_eight'),
                                  dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                  child: PeopleGroupWidget(person: widget.person,groupTypeModel: _groupTypeModels!.last,),
                                ),
                              );
                            }),
                          );
                        },
                        barrierColor: Colors.transparent,
                      ).then((value) {
                        context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
                      });
                    },
                    icon: Icon(FeatherIcons.maximize, color: AppTheme.colorBox('meeting_color_seven')),
                  ),
                ],
              ),
              const SizedBox(
                height: 4.0,
              ),
              Expanded(
                child: BlocBuilder<PeopleGroupBloc, PeopleGroupState>(
                  builder: (BuildContext context, PeopleGroupState state) {
                    if (state is RetrievePeopleGroupLoadedState) {
                      _peopleGroupModels = state.props[0] as List<PeopleGroupModel>;
                    }
                    if (_peopleGroupModels != null) {
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                minLeadingWidth: 8,
                                leading: Icon(
                                  FeatherIcons.users,
                                  size: 24,
                                  color: AppTheme.colorBox('meeting_color_seven'),
                                ),
                                title: Text(_peopleGroupModels![index].name ?? '', style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500)),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox();
                            },
                            itemCount: _peopleGroupModels!.length),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'), strokeWidth: 1.5));
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
