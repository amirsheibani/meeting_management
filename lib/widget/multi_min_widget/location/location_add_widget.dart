import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/location/bloc/location_bloc.dart';

class LocationAddWidget extends StatefulWidget {
  const LocationAddWidget({
    Key? key,
  }) : super(key: key);

  @override
  _LocationAddWidgetState createState() => _LocationAddWidgetState();
}

class _LocationAddWidgetState extends State<LocationAddWidget> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _latitude = TextEditingController();
  final TextEditingController _longitude = TextEditingController();
  final TextEditingController _description = TextEditingController();
  LocationModel? _locationModel;

  @override
  void initState() {
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
              BlocListener<LocationBloc, LocationState>(listener: (BuildContext context, LocationState state) {
                if (state is LocationErrorState) {
                  debugPrint('Location Ex:${state.props[0]}');
                } else if (state is NewLocationLoadedState) {
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
                        FeatherIcons.mapPin,
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
                    child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Languages.of(context).name, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: _name,
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(border: InputBorder.none),
                            onChanged: (value) {
                              _name.text = _name.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                              _name.selection = TextSelection.fromPosition(TextPosition(offset: _name.text.length));
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
                          )
                        ),
                        const SizedBox(height: 4),
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
                        const SizedBox(height: 4),
                        Text(Languages.of(context).address, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            controller: _address,
                            style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                            decoration: const InputDecoration(border: InputBorder.none),
                            onChanged: (value) {
                              _address.text = _address.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                              _address.selection = TextSelection.fromPosition(TextPosition(offset: _address.text.length));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0),
                        ),
                        const SizedBox(height: 4),
                        Text(Languages.of(context).meetingLocation, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr,
                                  controller: _latitude,
                                  style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(border: InputBorder.none,hintText: Languages.of(context).latitude),
                                  onChanged: (value) {
                                    _latitude.text = _latitude.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                    _latitude.selection = TextSelection.fromPosition(TextPosition(offset: _latitude.text.length));
                                  },
                                ),
                              ),
                              const SizedBox(width: 8.0,),
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  textDirection: TextDirection.ltr,
                                  controller: _longitude,
                                  style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_one'), fontWeight: FontWeight.w500),
                                  decoration: InputDecoration(border: InputBorder.none,hintText: Languages.of(context).longitude),
                                  onChanged: (value) {
                                    _longitude.text = _longitude.text.convertNumberWithLanguage().changeCharacterWithLanguage();
                                    _longitude.selection = TextSelection.fromPosition(TextPosition(offset: _longitude.text.length));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 8,
                          child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0),
                        ),
                        const SizedBox(height: 4),
                        Text(Languages.of(context).description, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            // minLines: 2,
                            maxLines: 10,
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
                          child: Divider(height: 2, color: AppTheme.colorBox('meetings_color_two'), indent: 8.0, endIndent: 8.0),
                        ),
                      ],
                    ),
                  ),
                )),
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
                              _locationModel = LocationModel(
                                name: _name.text,
                                code: _code.text,
                                address: _address.text,
                                latitude: int.parse(_latitude.text.convertNumberWithLanguage(languageEn: true)),
                                longitude: int.parse(_longitude.text.convertNumberWithLanguage(languageEn: true)),
                                description: _description.text,
                              );
                              context.read<LocationBloc>().add(AddLocationEvent(locationModel: _locationModel!));
                            },
                            child: Text(Languages.of(context).meetingButtonSave, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meeting_color_eight'), fontWeight: FontWeight.w300)),
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
