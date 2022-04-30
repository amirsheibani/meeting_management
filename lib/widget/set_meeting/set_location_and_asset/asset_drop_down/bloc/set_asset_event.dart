part of 'set_asset_bloc.dart';

abstract class SetAssetEvent extends Equatable {
  const SetAssetEvent();
}
class RetrieveAssetDropdownEvent extends SetAssetEvent {
  final int? id;
  final String? searchText;

  const RetrieveAssetDropdownEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}