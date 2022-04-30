import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/asset_list_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';

import 'asset_preview_widget.dart';

class AssetWidget extends StatefulWidget {
  const AssetWidget({Key? key}) : super(key: key);

  @override
  _AssetWidgetState createState() => _AssetWidgetState();
}

class _AssetWidgetState extends State<AssetWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssetBloc(context.read<AssetsRepository>()),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        return MediaQuery
            .of(context)
            .size
            .width < 740
            ? const AssetListWidget()
            : Row(
          children: [
            SizedBox(width: constraints.maxWidth * 0.4, child: const AssetListWidget()),
            SizedBox(width: constraints.maxWidth * 0.6, child: const AssetPreviewWidget()),
          ],
        );
      }),
    );
  }
}
