import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/person/model/person.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/model/people_group_model.dart';
import 'package:meeting_management/widget/multi_min_widget/people_group/widget/member/bloc/member_bloc.dart';
import 'package:meeting_management/logic/member/model/member_model.dart';
import 'package:reorderables/reorderables.dart';

import 'bloc/people_group/people_group_bloc.dart';
import 'widget/member/widget/member_dropdown_widget.dart';

class PeopleGroupPreviewWidget extends StatefulWidget {
  const PeopleGroupPreviewWidget({Key? key}) : super(key: key);

  @override
  _PeopleGroupPreviewWidgetState createState() => _PeopleGroupPreviewWidgetState();
}

class _PeopleGroupPreviewWidgetState extends State<PeopleGroupPreviewWidget> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _description = TextEditingController();

  PeopleGroupModel? _peopleGroupModel;
  Person? personSelect;
  List<Widget> children = [];

  // List<String> members = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MultiBlocListener(
            listeners: [
              BlocListener<PeopleGroupBloc, PeopleGroupState>(
                listener: (BuildContext context, PeopleGroupState state) {
                  if (state is PeopleGroupErrorState) {
                    debugPrint('PeopleGroup Ex:${state.props[0]}');
                  } else if (state is UpdatePeopleGroupLoadedState) {
                    context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
                  } else if (state is DeletePeopleGroupLoadedState){
                    context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
                  }
                },
              ),
            ],
            child: BlocBuilder<PeopleGroupBloc, PeopleGroupState>(
              builder: (BuildContext context, PeopleGroupState state) {
                if (state is ShowPeopleGroupLoadedState) {
                  _peopleGroupModel = state.props[0] as PeopleGroupModel;
                }
                if(_peopleGroupModel != null){
                  _name.text = _peopleGroupModel!.name ?? '';
                  _code.text = _peopleGroupModel!.code != null ? _peopleGroupModel!.code!.convertNumberWithLanguage() : '';
                  _description.text = _peopleGroupModel!.description != null ? _peopleGroupModel!.description!.convertNumberWithLanguage() : '';
                  context.read<MemberBloc>().add(RetrieveMemberEvent(_peopleGroupModel!.id!));
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: Container(
                          width: 128,
                          height: 128,
                          decoration: BoxDecoration(shape: BoxShape.circle, color: AppTheme.colorBox('meeting_color_four')),
                          child: Center(
                            child: Icon(
                              FeatherIcons.users,
                              color: AppTheme.colorBox('meeting_color_eight'),
                              size: 64,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          controller: _name,
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w400),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            _name.text = _name.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                            _name.selection = TextSelection.fromPosition(TextPosition(offset: _name.text.length));
                            // setState(() {});
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(Languages.of(context).code, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    textDirection: TextDirection.ltr,
                                    controller: _code,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                    decoration: const InputDecoration(border: InputBorder.none),
                                    onChanged: (value) {
                                      _code.text = _code.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                      _code.selection = TextSelection.fromPosition(TextPosition(offset: _code.text.length));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                  child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0),
                                ),
                                Text(Languages.of(context).description, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                                  child: TextField(
                                    maxLines: 3,
                                    keyboardType: TextInputType.text,
                                    controller: _description,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                    decoration: const InputDecoration(border: InputBorder.none),
                                    onChanged: (value) {
                                      _description.text = _description.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                      _description.selection = TextSelection.fromPosition(TextPosition(offset: _description.text.length));
                                    },
                                  ),
                                ),
                                SizedBox(height: 8, child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0)),
                                Text(Languages.of(context).meetingPeople, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MemberDropdownWidget(
                                          validations: [],
                                          change: (value) {
                                            personSelect = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8.0,
                                      ),
                                      SizedBox(
                                        width: 110,
                                        height: 34,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (personSelect != null) {
                                              MemberModel _memberModel = MemberModel();
                                              _memberModel.groupId = _peopleGroupModel!.id;
                                              if (personSelect!.type == 1) {
                                                _memberModel.partyPersonId = personSelect!.id;
                                              } else if (personSelect!.type == 3) {
                                                _memberModel.personId = personSelect!.id;
                                              }
                                              _memberModel.description = 'Nothing...';
                                              _memberModel.position = 'Nothing...';
                                              context.read<MemberBloc>().add(AddMemberEvent(memberModel: _memberModel));
                                              personSelect = null;
                                            }
                                          },
                                          child: Text(
                                            Languages.of(context).add,
                                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                                          ),
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_nine')),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                BlocConsumer<MemberBloc, MemberState>(
                                  builder: (context, MemberState state) {
                                    if (state is RetrieveMemberLoadedState) {
                                      children = [];
                                      for (var element in state.props[0]!) {
                                        children.add(
                                          InkWell(
                                            onDoubleTap: (){
                                              context.read<MemberBloc>().add(DeleteMemberEvent(id: element.id!));
                                            },
                                            onLongPress: (){
                                              context.read<MemberBloc>().add(DeleteMemberEvent(id: element.id!));
                                            },
                                            child: Text(' ${element.member!.firstName!} ${element.member!.lastName!} ',
                                                style: Theme.of(context).textTheme.headline6!.copyWith(
                                                    color: element.member!.type == 3 ? AppTheme.colorBox('meeting_color_eight') : AppTheme.colorBox('meeting_color_four'),
                                                    fontWeight: FontWeight.w600,
                                                    backgroundColor: element.member!.type == 3 ? AppTheme.colorBox('meeting_color_four') : AppTheme.colorBox('meeting_color_seven')),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                    if(children.isNotEmpty){
                                      return ReorderableWrap(controller: ScrollController(), needsLongPressDraggable: false, spacing: 8, runSpacing: 4, onReorder: (int oldIndex, int newIndex) {}, children: children);
                                    }else{
                                      return Center(child: CircularProgressIndicator(color: AppTheme.colorBox('meeting_color_eight'),strokeWidth: 1.5));
                                    }
                                  },
                                  listener: (BuildContext context, MemberState state) {
                                    if (state is MemberErrorState) {
                                      debugPrint('member list Ex:${state.props[0]}');
                                    } else if (state is NewMemberLoadedState || state is DeleteMemberLoadedState) {
                                      // context.read<PeopleGroupBloc>().add(const RetrievePeopleGroupEvent());
                                      context.read<MemberBloc>().add(RetrieveMemberEvent(_peopleGroupModel!.id!));
                                    }

                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80.0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 90,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    context.read<PeopleGroupBloc>().add(DeletePeopleGroupEvent(id: _peopleGroupModel!.id!));
                                  },
                                  child: Text(
                                    Languages.of(context).meetingButtonRemove,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_ten')),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 90,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    PeopleGroupModel peopleGroupModel = PeopleGroupModel(
                                      id: _peopleGroupModel!.id,
                                      name: _name.text,
                                      code: _code.text.convertNumberWithLanguage(languageEn: true),
                                      description: _description.text,
                                    );
                                    _peopleGroupModel = peopleGroupModel;
                                    context.read<PeopleGroupBloc>().add(UpdatePeopleGroupEvent(peopleGroupModel: peopleGroupModel));
                                  },
                                  child: Text(Languages.of(context).meetingButtonUpdate, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300)),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_four')),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                width: 90,
                                height: 34,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    Languages.of(context).meetingButtonCancel,
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    backgroundColor: MaterialStateProperty.all<Color>(AppTheme.colorBox('meeting_color_nine')),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
