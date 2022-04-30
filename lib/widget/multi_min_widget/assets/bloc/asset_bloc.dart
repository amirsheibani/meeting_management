import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/asset/model/asset_model.dart';
import 'package:meeting_management/logic/asset/repository/assets_repository.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  final AssetsRepository _assetsRepository;
  AssetBloc(this._assetsRepository) : super(AssetInitial()) {
    on<AddAssetEvent>((event, emit) async {
      try {
        final bool _result = await _assetsRepository.addAsset(event.props[0]);
        emit(NewAssetLoadedState(_result));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
    on<UpdateAssetEvent>((event, emit) async {
      try {
        final bool _result = await _assetsRepository.updateAsset(event.props[0]);
        emit(UpdateAssetLoadedState(_result));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
    on<DeleteAssetEvent>((event, emit) async {
      try {
        final bool _result = await _assetsRepository.deleteAsset(event.props[0]);
        emit(DeleteAssetLoadedState(_result));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
    on<RetrieveAssetEvent>((event, emit) async {
      try {
        final List<AssetModel> _result = await _assetsRepository.retrieveAsset(id:event.props[0],searchText: event.props[1]);
        emit(RetrieveAssetLoadedState(_result));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
    on<RetrieveAssetMeetingEvent>((event, emit) async {
      try {
        final List<int> _result = await _assetsRepository.retrieveAssetsMeeting(event.props[0]!);
        print('${_result}');
        emit(RetrieveAssetMeetingLoadedState(_result));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
    on<ShowAssetEvent>((event, emit) async {
      try {
        emit(ShowAssetLoadedState(event.props[0]));
      } catch (exception) {
        emit(AssetErrorState(exception));
      }
    });
  }
}
