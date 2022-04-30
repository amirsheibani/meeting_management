part of 'meeting_hourly_bloc.dart';

abstract class MeetingHourlyEvent extends Equatable {
  const MeetingHourlyEvent();
}
class RetrieveMeetingHourlyEvent extends MeetingHourlyEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const RetrieveMeetingHourlyEvent({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate,toDate];
}