import 'package:flutter/material.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/theme/theme.dart';
import 'package:reorderables/reorderables.dart';

import 'asset_drop_down/widget/asset_drop_down_widget.dart';

class SetAssetWidget extends StatefulWidget {
  const SetAssetWidget({Key? key, required this.scaffoldKey, required this.change}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Function(List<AssetModel>) change;
  @override
  _SetAssetWidgetState createState() => _SetAssetWidgetState();
}

class _SetAssetWidgetState extends State<SetAssetWidget> {
  List<AssetModel> items = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AssetDropdownWidget(scaffoldKey: widget.scaffoldKey, validations: [], change: (value){
          if(items.where((element) => element.name == value.name).toList().isEmpty){
            items.add(value);
            widget.change(items);
            setState(() {});
          }
        },
        ),
        Expanded(
            child: ReorderableWrap(
                controller: ScrollController(),
                needsLongPressDraggable: false,
                spacing: 8,
                runSpacing: 4,
                onReorder: (int oldIndex, int newIndex) {},
                children: items.map((element) {
                  return InkWell(
                    onTap: () {

                    },
                    onDoubleTap: () {
                      setState(() {
                        items.remove(element);
                      });
                    },
                    child: Text(' ${element.name} ',
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                          color: AppTheme.colorBox('meeting_color_eight'),
                          fontWeight: FontWeight.w600,
                          backgroundColor: AppTheme.colorBox('meeting_color_four')),
                    ),
                  );
                }).toList()),
        ),
      ],
    );
  }
}
