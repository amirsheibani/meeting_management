part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();
}

class AddAssetEvent extends AssetEvent {
  final AssetModel assetModel;

  const AddAssetEvent({required this.assetModel});
  @override
  List<AssetModel> get props => [assetModel];
}
class UpdateAssetEvent extends AssetEvent {
  final AssetModel assetModel;

  const UpdateAssetEvent({required this.assetModel});
  @override
  List<AssetModel> get props => [assetModel];
}
class DeleteAssetEvent extends AssetEvent {
  final int id;

  const DeleteAssetEvent({required this.id});
  @override
  List<int> get props => [id];
}
class RetrieveAssetEvent extends AssetEvent {
  final int? id;
  final String? searchText;

  const RetrieveAssetEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}
class RetrieveAssetMeetingEvent extends AssetEvent {
  final int? id;

  const RetrieveAssetMeetingEvent({this.id});
  @override
  List<dynamic> get props => [id];
}
class ShowAssetEvent extends AssetEvent {
  final AssetModel assetModel;

  const ShowAssetEvent(this.assetModel);
  @override
  List<dynamic> get props => [assetModel];
}

