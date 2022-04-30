import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/widget/member/bloc/member_bloc.dart';

import 'bloc/people_group/people_group_bloc.dart';
import 'model/group_type_model.dart';
import 'people_group_list_widget.dart';
import 'people_group_preview_widget.dart';
import 'repository/people_group_repository.dart';
import 'widget/member/widget/bloc/person_dropdown_bloc.dart';

import 'package:meeting_management/logic/member/repository/member_repository.dart';

class PeopleGroupWidget extends StatefulWidget {
  const PeopleGroupWidget({Key? key, required this.person, required this.groupTypeModel}) : super(key: key);
  final Person person;
  final GroupTypeModel groupTypeModel;

  @override
  _PeopleGroupWidgetState createState() => _PeopleGroupWidgetState();
}

class _PeopleGroupWidgetState extends State<PeopleGroupWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PeopleGroupBloc(context.read<PeopleGroupRepository>())),
        BlocProvider(create: (context) => MemberBloc(context.read<MemberRepository>())),
        BlocProvider(create: (context) => PersonDropdownBloc(context.read<MemberRepository>())),
      ],
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return MediaQuery.of(context).size.width < 740
            ? PeopleGroupListWidget(
                person: widget.person,
                groupTypeModel: widget.groupTypeModel,
              )
            : Row(
                children: [
                  SizedBox(
                      width: constraints.maxWidth * 0.4,
                      child: PeopleGroupListWidget(
                        person: widget.person,
                        groupTypeModel: widget.groupTypeModel,
                      )),
                  SizedBox(width: constraints.maxWidth * 0.6, child: const PeopleGroupPreviewWidget()),
                ],
              );
      }),
    );
  }
}
