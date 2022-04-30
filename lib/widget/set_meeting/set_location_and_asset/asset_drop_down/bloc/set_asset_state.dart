part of 'set_asset_bloc.dart';

abstract class SetAssetState extends Equatable {
  const SetAssetState();
}

class SetAssetInitial extends SetAssetState {
  @override
  List<Object> get props => [];
}
class RetrieveAssetDropdownLoadedState extends SetAssetState {
  final List<AssetModel> assets;
  const RetrieveAssetDropdownLoadedState(this.assets);
  @override
  List<List<AssetModel>> get props => [assets];
}

class AssetDropdownErrorState extends SetAssetState {
  final dynamic error;
  const AssetDropdownErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}