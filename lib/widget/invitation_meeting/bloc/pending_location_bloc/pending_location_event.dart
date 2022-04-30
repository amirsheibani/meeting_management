part of 'pending_location_bloc.dart';

abstract class PendingLocationEvent extends Equatable {
  const PendingLocationEvent();
}
class RetrieveLocationMeetingEvent extends PendingLocationEvent {
  final int id;
  const RetrieveLocationMeetingEvent(this.id);
  @override
  List<int?> get props => [id];
}