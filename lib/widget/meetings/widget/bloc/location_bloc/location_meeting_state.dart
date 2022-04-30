part of 'location_meeting_bloc.dart';

abstract class LocationMeetingState extends Equatable {
  const LocationMeetingState();
}

class LocationMeetingInitial extends LocationMeetingState {
  @override
  List<Object> get props => [];
}
class LocationMeetingRetrieve extends LocationMeetingState {
  final List<LocationModel> result;

  const LocationMeetingRetrieve(this.result);

  @override
  List<List<LocationModel>> get props => [result];
}
class LocationMeetingError extends LocationMeetingState {
  final dynamic error;
  const LocationMeetingError(this.error);
  @override
  List<dynamic> get props => [error];
}