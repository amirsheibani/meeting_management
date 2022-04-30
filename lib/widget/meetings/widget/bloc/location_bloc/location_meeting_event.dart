part of 'location_meeting_bloc.dart';

abstract class LocationMeetingEvent extends Equatable {
  const LocationMeetingEvent();
}
class RetrieveLocationMeetingEvent extends LocationMeetingEvent {
  final int id;
  const RetrieveLocationMeetingEvent(this.id);
  @override
  List<int?> get props => [id];
}