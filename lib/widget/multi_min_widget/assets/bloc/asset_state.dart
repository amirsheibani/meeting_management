part of 'asset_bloc.dart';

abstract class AssetState extends Equatable {
  const AssetState();
}

class AssetInitial extends AssetState {
  @override
  List<Object> get props => [];
}
class NewAssetLoadedState extends AssetState {
  final bool status;
  const NewAssetLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class UpdateAssetLoadedState extends AssetState {
  final bool status;
  const UpdateAssetLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeleteAssetLoadedState extends AssetState {
  final bool status;
  const DeleteAssetLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class RetrieveAssetLoadedState extends AssetState {
  final List<AssetModel> assets;
  const RetrieveAssetLoadedState(this.assets);
  @override
  List<Object?> get props => [assets];
}
class RetrieveAssetMeetingLoadedState extends AssetState {
  final List<int> assets;
  const RetrieveAssetMeetingLoadedState(this.assets);
  @override
  List<Object?> get props => [assets];
}
class ShowAssetLoadedState extends AssetState {
  final AssetModel assetModel;
  const ShowAssetLoadedState(this.assetModel);
  @override
  List<Object?> get props => [assetModel];
}
class AssetErrorState extends AssetState {
  final dynamic error;
  const AssetErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}
