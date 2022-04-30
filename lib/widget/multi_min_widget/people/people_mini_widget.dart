import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/people/people_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/unit/people_unit_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/people_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/people_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/unit_repository.dart';

import 'model/people_model.dart';
import 'people_add_widget.dart';

class PeopleMiniWidget extends StatefulWidget {
  const PeopleMiniWidget({Key? key}) : super(key: key);

  @override
  _PeopleMiniWidgetState createState() => _PeopleMiniWidgetState();
}

class _PeopleMiniWidgetState extends State<PeopleMiniWidget> {
  @override
  void initState() {
    context.read<PeopleBloc>().add(const RetrievePeopleEvent());
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
                    Languages.of(context).meetingPeople,
                    style: Theme.of(context).textTheme.headline4!.copyWith(fontSize: 20, color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  padding: const EdgeInsets.all(0.0),
                  tooltip: Languages.of(context).add,
                  iconSize: 36,
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
                                leading: Icon(FeatherIcons.user, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                title: Text(Languages.of(context).add, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                headerColor: AppTheme.colorBox('meeting_color_four'),
                                headerHeight: 80,
                                background: AppTheme.colorBox('meeting_color_eight'),
                                dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                child: MultiBlocProvider(
                                  providers: [
                                    BlocProvider(create: (context) => PeopleUnitBloc(context.read<UnitRepository>())),
                                    BlocProvider(create: (context) => PeopleBloc(context.read<PeopleRepository>())),
                                  ],
                                  child: const PeopleAddWidget(),
                                ),
                              ),
                            );
                          }),
                        );
                      },
                      barrierColor: Colors.transparent,
                    ).then((value) {
                      if (value != null) {
                        context.read<PeopleBloc>().add(const RetrievePeopleEvent());
                      }
                    });
                  },
                  icon: Icon(
                    FeatherIcons.plusCircle,
                    color: AppTheme.colorBox('meetings_color_one') ?? Colors.black,
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
                                leading: Icon(FeatherIcons.user, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                title: Text(Languages.of(context).meetingPeople, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                headerColor: AppTheme.colorBox('meeting_color_four'),
                                headerHeight: 80,
                                background: AppTheme.colorBox('meeting_color_eight'),
                                dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                child: const PeopleWidget(),
                              ),
                            );
                          }),
                        );
                      },
                      barrierColor: Colors.transparent,
                    ).then((value) {
                      context.read<PeopleBloc>().add(const RetrievePeopleEvent());
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
              child: BlocListener<PeopleBloc, PeopleState>(
                listener: (BuildContext context, PeopleState state) {
                  if (state is PeopleErrorState) {
                    debugPrint('people Ex:${state.props[0]}');
                  }
                },
                child: BlocBuilder<PeopleBloc, PeopleState>(
                  builder: (BuildContext context, PeopleState state) {
                    if (state is RetrievePeopleLoadedState) {
                      List<PeopleModel> peoples = state.props[0] as List<PeopleModel>;
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: ListView.separated(
                              controller: ScrollController(),
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  minLeadingWidth: 8,
                                  leading: Icon(FeatherIcons.user,size: 24,color: AppTheme.colorBox('meeting_color_seven'),),
                                  title: Row(
                                    children: [
                                      Text(peoples[index].firstName!, style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w300)),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      Text(
                                        peoples[index].lastName!,
                                        style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return const SizedBox();
                              },
                              itemCount: peoples.length),
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'), strokeWidth: 1.5));
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
