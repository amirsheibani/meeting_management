part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();
}
class AddLocationEvent extends LocationEvent {
  final LocationModel locationModel;

  const AddLocationEvent({required this.locationModel});
  @override
  List<LocationModel> get props => [locationModel];
}
class UpdateLocationEvent extends LocationEvent {
  final LocationModel locationModel;

  const UpdateLocationEvent({required this.locationModel});
  @override
  List<LocationModel> get props => [locationModel];
}
class DeleteLocationEvent extends LocationEvent {
  final int id;

  const DeleteLocationEvent({required this.id});
  @override
  List<int> get props => [id];
}
class RetrieveLocationEvent extends LocationEvent {
  final int? id;
  final String? searchText;

  const RetrieveLocationEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}

class ShowLocationEvent extends LocationEvent {
  final LocationModel locationModel;

  const ShowLocationEvent(this.locationModel);
  @override
  List<dynamic> get props => [locationModel];
}