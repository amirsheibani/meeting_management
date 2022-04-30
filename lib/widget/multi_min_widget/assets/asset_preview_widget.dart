import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:meeting_management/constant.dart';
import 'package:meeting_management/language/languages/languages.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:meeting_management/widget/multi_min_widget/assets/bloc/asset_bloc.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';



class AssetPreviewWidget extends StatefulWidget {
  const AssetPreviewWidget({Key? key}) : super(key: key);

  @override
  _AssetPreviewWidgetState createState() => _AssetPreviewWidgetState();
}

class _AssetPreviewWidgetState extends State<AssetPreviewWidget> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _code= TextEditingController();
  final TextEditingController _description = TextEditingController();

  AssetModel? _assetModel;

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
              BlocListener<AssetBloc, AssetState>(
                listener: (BuildContext context, AssetState state) {
                  if (state is AssetErrorState) {
                    debugPrint('asset list Ex:${state.props[0]}');
                  } else if (state is UpdateAssetLoadedState) {
                    context.read<AssetBloc>().add(const RetrieveAssetEvent());
                  }
                },
              ),
            ],
            child: BlocBuilder<AssetBloc, AssetState>(
              builder: (BuildContext context, AssetState state) {
                if (state is ShowAssetLoadedState) {
                  _assetModel = state.props[0] as AssetModel;
                  _name.text = _assetModel!.name ?? '';
                  _code.text = _assetModel!.code != null ? _assetModel!.code!.convertNumberWithLanguage() : '';
                  _description.text = _assetModel!.description != null ? _assetModel!.description!.convertNumberWithLanguage() : '';
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
                              FeatherIcons.server,
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
                          decoration: const InputDecoration(border: InputBorder.none,),
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
                                  child: Divider(
                                    height: 2,
                                    color: AppTheme.colorBox('meetings_color_two'),
                                    indent: 8.0,
                                    endIndent: 8.0
                                  ),
                                ),
                                Text(Languages.of(context).description, style: Theme.of(context).textTheme.headline6!.copyWith(color: AppTheme.colorBox('meetings_color_two'), fontWeight: FontWeight.w600)),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                                  child: TextField(
                                    maxLines: 10,
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
                        ),
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
                                    context.read<AssetBloc>().add(DeleteAssetEvent(id: _assetModel!.id!));
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
                                    AssetModel assetModel = AssetModel(
                                      id: _assetModel!.id,
                                      name: _name.text,
                                      code: _code.text.convertNumberWithLanguage(languageEn: true),
                                      description: _description.text,
                                    );
                                    context.read<AssetBloc>().add(UpdateAssetEvent(assetModel: assetModel));
                                  },
                                  child: Text(Languages.of(context).meetingButtonUpdate,
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
