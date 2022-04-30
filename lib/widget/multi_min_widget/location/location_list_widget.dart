import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';


import 'bloc/location_bloc.dart';
import 'location_add_widget.dart';

class LocationListWidget extends StatefulWidget {
  const LocationListWidget({Key? key}) : super(key: key);

  @override
  _LocationListWidgetState createState() => _LocationListWidgetState();
}

class _LocationListWidgetState extends State<LocationListWidget> {
  List<LocationModel> locations = [];

  @override
  void initState() {
    context.read<LocationBloc>().add(const RetrieveLocationEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            const SizedBox(
              width: 8.0,
            ),
            IconButton(
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
                              leading: Icon(FeatherIcons.mapPin, size: 48, color: AppTheme.colorBox('meeting_color_eight')),
                              title: Text(Languages.of(context).add, style: Theme.of(context).textTheme.headline3!.copyWith(fontWeight: FontWeight.w500, color: AppTheme.colorBox('meeting_color_eight'))),
                              headerColor: AppTheme.colorBox('meeting_color_four'),
                              headerHeight: 80,
                              background: AppTheme.colorBox('meeting_color_eight'),
                              dismissColorIcon: AppTheme.colorBox('meeting_color_eight'),
                              child: MultiBlocProvider(
                                providers: [
                                  BlocProvider(create: (context) => LocationBloc(context.read<LocationRepository>())),
                                ],
                                child: const LocationAddWidget(),
                              ),
                            ),
                          );
                        }),
                      );
                    },
                    barrierColor: Colors.transparent,
                  ).then((value) {
                    if (value != null) {
                      context.read<LocationBloc>().add(const RetrieveLocationEvent());
                    }
                  });
                },
                icon: Icon(
                  FeatherIcons.plus,
                  color: AppTheme.colorBox('meeting_color_four'),
                ))
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: BlocListener<LocationBloc, LocationState>(
            listener: (BuildContext context, LocationState state) {
              if (state is LocationErrorState) {
                debugPrint('location list Ex:${state.props[0]}');
              }
            },
            child: BlocBuilder<LocationBloc, LocationState>(
              builder: (BuildContext context, LocationState state) {
                if (state is RetrieveLocationLoadedState) {
                  locations = state.props[0] as List<LocationModel>;
                }
                if (locations.isEmpty) {
                  return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'), strokeWidth: 1.5));
                } else {
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(width: double.maxFinite, height: 3, child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0));
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppTheme.colorBox('meeting_color_four'),
                            ),
                            child: Center(
                                child: Text(
                                  locations[index].name!.substring(0, 1).toUpperCase(),
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w600),
                            )),
                          ),
                          title: Text(
                            locations[index].name!,
                            style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                          ),
                          onTap: () {
                            context.read<LocationBloc>().add(ShowLocationEvent(locations[index]));
                          },
                        );
                      },
                      itemCount: locations.length + 1);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
