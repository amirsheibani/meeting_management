import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/dialog/dialog.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/people/people_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/people_widget.dart';

import 'bloc/unit/people_unit_bloc.dart';
import 'model/people_model.dart';
import 'people_add_widget.dart';
import 'repository/people_repository.dart';
import 'repository/unit_repository.dart';

class PeopleListWidget extends StatefulWidget {
  const PeopleListWidget({Key? key}) : super(key: key);

  @override
  _PeopleListWidgetState createState() => _PeopleListWidgetState();
}

class _PeopleListWidgetState extends State<PeopleListWidget> {

  List<PeopleModel> peoples = [];
  @override
  void initState() {
    context.read<PeopleBloc>().add(const RetrievePeopleEvent());
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
                  FeatherIcons.plus,
                  color: AppTheme.colorBox('meeting_color_four'),
                ))
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        Expanded(
          child: BlocListener<PeopleBloc, PeopleState>(
            listener: (BuildContext context, PeopleState state) {
              if(state is PeopleErrorState){
                debugPrint('people list Ex:${state.props[0]}');
              }
            },
            child: BlocBuilder<PeopleBloc, PeopleState>(
              builder: (BuildContext context, PeopleState state) {
                if(state is RetrievePeopleLoadedState){
                  peoples = state.props[0] as List<PeopleModel>;
                }
                if(peoples.isEmpty){
                  return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'),strokeWidth: 1.5,));
                }else{
                  return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width: double.maxFinite,
                            height: 3,
                            child: Divider(
                              height: 2,
                              color: AppTheme.colorBox('meetings_color_two'),
                              indent: 8.0,
                              endIndent: 8.0,
                            ));
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
                                  peoples[index].lastName!.substring(0, 1).toUpperCase(),
                                  style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w600),
                                )),
                          ),
                          title: Text(
                            '${peoples[index].firstName} ${peoples[index].lastName}',
                            style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                          ),
                          onTap: (){
                            context.read<PeopleBloc>().add(ShowPeopleEvent(peoples[index]));
                          },
                        );
                      },
                      itemCount: peoples.length+1);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
