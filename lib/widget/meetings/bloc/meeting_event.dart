part of 'meeting_bloc.dart';

abstract class MeetingEvent extends Equatable {
  const MeetingEvent();
}
class RetrieveMeetingEvent extends MeetingEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const RetrieveMeetingEvent(this.fromDate,this.toDate);
  @override
  List<Object?> get props => [fromDate,toDate];
}