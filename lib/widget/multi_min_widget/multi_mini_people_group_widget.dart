import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/assets_mini_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/location/location_mini_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/people/people_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/people_mini_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/people_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/bloc/people_group/people_group_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/people_group_mini_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/repository/people_group_repository.dart';

class MultiMiniPeopleGroupWidget extends StatefulWidget {
  const MultiMiniPeopleGroupWidget({Key? key, required this.person}) : super(key: key);

  final Person person;

  @override
  _MultiMiniPeopleGroupWidgetState createState() => _MultiMiniPeopleGroupWidgetState();
}

class _MultiMiniPeopleGroupWidgetState extends State<MultiMiniPeopleGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => PeopleBloc(context.read<PeopleRepository>()),
              ),
              BlocProvider(
                create: (context) => PeopleGroupBloc(context.read<PeopleGroupRepository>()),
              ),
            ],
            child: Column(
              children: [
                const Expanded(
                  child: PeopleMiniWidget(),
                ),
                const SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: PeopleGroupMiniWidget(person: widget.person,),
                ),
              ],
            ),
          );
        }
    );
  }
}
