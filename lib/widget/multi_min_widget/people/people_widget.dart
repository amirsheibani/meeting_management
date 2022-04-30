import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/people/people_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/people_preview_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/people_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/people/repository/unit_repository.dart';

import 'bloc/unit/people_unit_bloc.dart';
import 'people_list_widget.dart';

class PeopleWidget extends StatefulWidget {
  const PeopleWidget({Key? key}) : super(key: key);

  @override
  _PeopleWidgetState createState() => _PeopleWidgetState();
}

class _PeopleWidgetState extends State<PeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PeopleBloc(context.read<PeopleRepository>()),
        ),
        BlocProvider(
          create: (context) => PeopleUnitBloc(context.read<UnitRepository>()),
        ),
      ],
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return MediaQuery
            .of(context)
            .size
            .width < 740
            ? const PeopleListWidget()
            : Row(
          children: [
            SizedBox(width: constraints.maxWidth * 0.4, child: const PeopleListWidget()),
            SizedBox(width: constraints.maxWidth * 0.6, child: const PeoplePreviewWidget()),
          ],
        );
      }),
    );
  }
}
