import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';

part 'set_asset_event.dart';
part 'set_asset_state.dart';

class SetAssetBloc extends Bloc<SetAssetEvent, SetAssetState> {
  final AssetsRepository _assetsRepository;
  SetAssetBloc(this._assetsRepository) : super(SetAssetInitial()) {
    on<RetrieveAssetDropdownEvent>((event, emit) async {
      try {
        final List<AssetModel> _result = await _assetsRepository.retrieveAsset(id:event.props[0],searchText: event.props[1]);
        emit(RetrieveAssetDropdownLoadedState(_result));
      } catch (exception) {
        emit(AssetDropdownErrorState(exception));
      }
    });
  }
}
