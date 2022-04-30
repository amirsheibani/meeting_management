part of 'pending_location_bloc.dart';

abstract class PendingLocationState extends Equatable {
  const PendingLocationState();
}

class PendingLocationInitial extends PendingLocationState {
  @override
  List<Object> get props => [];
}
class LocationMeetingRetrieve extends PendingLocationState {
  final List<LocationModel> result;

  const LocationMeetingRetrieve(this.result);

  @override
  List<List<LocationModel>> get props => [result];
}
class LocationMeetingError extends PendingLocationState {
  final dynamic error;
  const LocationMeetingError(this.error);
  @override
  List<dynamic> get props => [error];
}