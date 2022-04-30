part of 'meeting_daily_bloc.dart';

abstract class MeetingDailyEvent extends Equatable {
  const MeetingDailyEvent();
}
class RetrieveMeetingDailyEvent extends MeetingDailyEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const RetrieveMeetingDailyEvent({this.fromDate, this.toDate});
  @override
  List<Object?> get props => [fromDate,toDate];
}