import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/asset_widget.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';

import 'asset_add_widget.dart';

class AssetsMiniWidget extends StatefulWidget {
  const AssetsMiniWidget({Key? key}) : super(key: key);

  @override
  _AssetsMiniWidgetState createState() => _AssetsMiniWidgetState();
}

class _AssetsMiniWidgetState extends State<AssetsMiniWidget> {

  @override
  void initState() {
    context.read<AssetBloc>().add(const RetrieveAssetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppTheme.colorBox('meeting_color_four') ?? const Color(0xFF030F34),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    FeatherIcons.server,
                    size: 36,
                    color: AppTheme.colorBox('meeting_color_eight') ?? Colors.white,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: Text(
                      Languages.of(context).meetingAssets,
                      style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w600),
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
                                  leading: Icon(FeatherIcons.server, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                  title: Text(Languages.of(context).add, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                  headerColor: AppTheme.colorBox('meeting_color_four'),
                                  headerHeight: 80,
                                  background: AppTheme.colorBox('meeting_color_eight'),
                                  dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                  child: BlocProvider(create: (context) => AssetBloc(context.read<AssetsRepository>()),
                                  child: const AssetAddWidget(),),
                                ),
                              );
                            }),
                          );
                        },
                        barrierColor: Colors.transparent,
                      ).then((value) {
                        if (value != null) {
                          context.read<AssetBloc>().add(const RetrieveAssetEvent());
                        }
                      });
                    },
                    icon: Icon(
                      FeatherIcons.plusCircle,
                      color: AppTheme.colorBox('meeting_color_eight') ?? Colors.black,
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
                                  leading: Icon(FeatherIcons.server, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                                  title: Text(Languages.of(context).meetingAssets, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                                  headerColor: AppTheme.colorBox('meeting_color_four'),
                                  headerHeight: 80,
                                  background: AppTheme.colorBox('meeting_color_eight'),
                                  dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                                  child: const AssetWidget(),
                                ),
                              );
                            }),
                          );
                        },
                        barrierColor: Colors.transparent,
                      ).then((value) {
                        context.read<AssetBloc>().add(const RetrieveAssetEvent());
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
                child: BlocBuilder<AssetBloc, AssetState>(
                  builder: (BuildContext context, AssetState state) {
                    if (state is RetrieveAssetLoadedState) {
                      List<AssetModel> _assets = state.props[0] as List<AssetModel>;
                      return ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                        child: ListView.separated(
                            controller: ScrollController(),
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                minLeadingWidth: 8,
                                leading: Icon(FeatherIcons.server,size: 24,color: AppTheme.colorBox('meeting_color_seven'),),
                                title: Text(_assets[index].name ?? '',style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w500)),
                              );
                            },
                            separatorBuilder: (BuildContext context, int index) {
                              return const SizedBox();
                            },
                            itemCount: _assets.length),
                      );
                    }
                    return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'), strokeWidth: 1.5));
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
