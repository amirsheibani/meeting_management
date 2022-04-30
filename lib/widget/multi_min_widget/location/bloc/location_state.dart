part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();
}

class LocationInitial extends LocationState {
  @override
  List<Object> get props => [];
}
class NewLocationLoadedState extends LocationState {
  final bool status;
  const NewLocationLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class UpdateLocationLoadedState extends LocationState {
  final bool status;
  const UpdateLocationLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeleteLocationLoadedState extends LocationState {
  final bool status;
  const DeleteLocationLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class RetrieveLocationLoadedState extends LocationState {
  final List<LocationModel> locations;
  const RetrieveLocationLoadedState(this.locations);
  @override
  List<Object?> get props => [locations];
}

class ShowLocationState extends LocationState {
  final LocationModel locationModel;
  const ShowLocationState(this.locationModel);
  @override
  List<Object?> get props => [locationModel];
}

class LocationErrorState extends LocationState {
  final dynamic error;
  const LocationErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}