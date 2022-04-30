import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/assets_mini_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';
import 'package:meeting_management/widget/multi_min_widget/location/bloc/location_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/location/location_mini_widget.dart';

class MultiMiniAssetsLocationWidget extends StatefulWidget {
  const MultiMiniAssetsLocationWidget({Key? key}) : super(key: key);

  @override
  _MultiMiniAssetsLocationWidgetState createState() => _MultiMiniAssetsLocationWidgetState();
}

class _MultiMiniAssetsLocationWidgetState extends State<MultiMiniAssetsLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AssetBloc(context.read<AssetsRepository>()),
        ),
        BlocProvider(
          create: (context) => LocationBloc(context.read<LocationRepository>()),
        ),
      ],
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: const [
                Expanded(
                    child: LocationMiniWidget()
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: AssetsMiniWidget(),
                ),
              ],
            );
          }
      ),
    );
  }
}
