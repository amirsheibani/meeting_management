import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/location/bloc/location_bloc.dart';

import 'location_list_widget.dart';
import 'location_preview_widget.dart';

class LocationWidget extends StatefulWidget {
  const LocationWidget({Key? key}) : super(key: key);

  @override
  _LocationWidgetState createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc(context.read<LocationRepository>()),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return MediaQuery
            .of(context)
            .size
            .width < 740
            ? const LocationListWidget()
            : Row(
          children: [
            SizedBox(width: constraints.maxWidth * 0.4, child: const LocationListWidget()),
            SizedBox(width: constraints.maxWidth * 0.6, child: const LocationPreviewWidget()),
          ],
        );
      }),
    );
  }
}
