import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/people/people_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/bloc/unit/people_unit_bloc.dart';
import 'package:meeting_management/widget/multi_min_widget/people/model/unit_model.dart';

import 'model/people_model.dart';

class PeopleAddWidget extends StatefulWidget {
  const PeopleAddWidget({Key? key,}) : super(key: key);

  @override
  _PeopleAddWidgetState createState() => _PeopleAddWidgetState();
}

class _PeopleAddWidgetState extends State<PeopleAddWidget> {
  final TextEditingController _lastname = TextEditingController();
  final TextEditingController _firstname = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _unit = TextEditingController();
  PeopleModel? _peopleModel;
  List<UnitModel> _units = [];

  @override
  void initState() {
    context.read<PeopleUnitBloc>().add(const RetrieveUnitEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return MultiBlocListener(
            listeners: [
              BlocListener<PeopleUnitBloc, PeopleUnitState>(
                  listener: (BuildContext context,PeopleUnitState state){
                if(state is PeopleUnitErrorState){
                  debugPrint('PeopleUnit Ex:${state.props[0]}');
                }else if(state is RetrievePeopleUnitLoadedState){
                  _units = state.props[0] as List<UnitModel>;
                }else if(state is NewPeopleUnitLoadedState){
                  _peopleModel!.unitId = (state.props[0] as UnitModel).id;
                  context.read<PeopleBloc>().add(AddPeopleEvent(peopleModel: _peopleModel!));
                }
              }),
              BlocListener<PeopleBloc, PeopleState>(listener: (BuildContext context,PeopleState state){
                if(state is PeopleErrorState){
                  debugPrint('People Ex:${state.props[0]}');
                }else if(state is NewPeopleLoadedState){
                  Navigator.of(context).pop([]);
                }
                }),
            ],
            child: Column(
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
                        FeatherIcons.user,
                        color: AppTheme.colorBox('meeting_color_eight'),
                        size: 64,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                    child:ScrollConfiguration(
                      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(Languages.of(context).firstname, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w400)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _firstname,
                                style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w400),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _firstname.text = _firstname.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _firstname.selection = TextSelection.fromPosition(TextPosition(offset: _firstname.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).lastname, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w400)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _lastname,
                                style: Theme.of(context).textTheme.headline4!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _lastname.text = _lastname.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _lastname.selection = TextSelection.fromPosition(TextPosition(offset: _lastname.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).unit, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w400)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TypeAheadFormField(
                                hideOnEmpty: true,
                                textFieldConfiguration: TextFieldConfiguration(
                                  controller: _unit,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w600),
                                  decoration: const InputDecoration(border: InputBorder.none),
                                  onChanged: (value) {
                                    _unit.text = _unit.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                    _unit.selection = TextSelection.fromPosition(TextPosition(offset: _unit.text.length));
                                  },
                                ),
                                suggestionsCallback: (pattern) {
                                  List<String> _unitsName = [];
                                  for(var itme in _units){
                                    if(itme.name!.contains(pattern)){
                                      _unitsName.add(itme.name!);
                                    }
                                  }
                                  return _unitsName;
                                },
                                itemBuilder: (context, String suggestion) {
                                  return Container(
                                    color: AppTheme.colorBox('meeting_color_four'),
                                    child: Container(
                                      color: AppTheme.colorBox('meeting_color_four'),
                                      child: ListTile(
                                        title: Text(suggestion,style: Theme.of(context).textTheme.headline5!.copyWith(color: AppTheme.colorBox('meeting_color_eight')),),
                                      ),
                                    ),
                                  );
                                },
                                transitionBuilder: (context, suggestionsBox, controller) {
                                  return suggestionsBox;
                                },
                                onSuggestionSelected: (String suggestion) {
                                  _unit.text = suggestion;
                                },
                                // validator: (value) {
                                //   if (value.isEmpty) {
                                //     return 'Please select a city';
                                //   }
                                // },
                                onSaved: (value) => _unit.text = value!,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).mobile, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.ltr,
                                controller: _mobile,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _mobile.text = _mobile.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _mobile.selection = TextSelection.fromPosition(TextPosition(offset: _mobile.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).email, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                textDirection: TextDirection.ltr,
                                controller: _email,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _email.text = _email.text.convertNumberWithLanguage(languageEn: true).changeCharacterWithLanguage(languageEn: true);
                                  _email.selection = TextSelection.fromPosition(TextPosition(offset: value.length));
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).phone, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.ltr,
                                controller: _phone,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _phone.text = _phone.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _phone.selection = TextSelection.fromPosition(TextPosition(offset: _phone.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).address, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.streetAddress,
                                controller: _address,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _address.text = _address.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _address.selection = TextSelection.fromPosition(TextPosition(offset: _address.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(Languages.of(context).description, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _description,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                decoration: const InputDecoration(border: InputBorder.none),
                                onChanged: (value) {
                                  _description.text = _description.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                  _description.selection = TextSelection.fromPosition(TextPosition(offset: _description.text.length));
                                  // setState(() {});
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                              child: Divider(
                                height: 2,
                                color: AppTheme.colorBox('meetings_color_two'),
                                indent: 8.0,
                                endIndent: 8.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                ),
                SizedBox(
                  height: 80.0,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0,left: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 90,
                          height: 34,
                          child: ElevatedButton(
                            onPressed: () {
                              _peopleModel = PeopleModel(
                                firstName: _firstname.text,
                                lastName: _lastname.text,
                                cellPhone: _mobile.text.convertNumberWithLanguage(languageEn: true),
                                phone: _phone.text.convertNumberWithLanguage(languageEn: true),
                                address: _address.text,
                                email: _email.text,
                                description: _description.text,
                              );
                              UnitModel? _unitModelFind;
                              for(var item in _units){
                                if(item.name == _unit.text){
                                  _unitModelFind = item;
                                  break;
                                }
                              }
                              if(_unitModelFind != null){
                                _peopleModel!.unitId = _unitModelFind.id;
                                context.read<PeopleBloc>().add(AddPeopleEvent(peopleModel: _peopleModel!));
                              }else{
                                context.read<PeopleUnitBloc>().add(AddUnitEvent(unitModel: UnitModel(name: _unit.text)));
                              }

                            },
                            child: Text(Languages.of(context).meetingButtonSave,
                                style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300)),
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
            ),
          );
        },
      ),
    );
  }
}
