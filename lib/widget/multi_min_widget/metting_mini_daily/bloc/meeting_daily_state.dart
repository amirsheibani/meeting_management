part of 'meeting_daily_bloc.dart';

abstract class MeetingDailyState extends Equatable {
  const MeetingDailyState();
}

class MeetingDailyInitial extends MeetingDailyState {
  @override
  List<Object> get props => [];
}
class MeetingDailyRetrieve extends MeetingDailyState {
  final List<MeetingModel> result;
  final DateTime fromDate;

  const MeetingDailyRetrieve(this.result, this.fromDate);

  @override
  List<dynamic> get props => [result,fromDate];
}
class MeetingDailyError extends MeetingDailyState {
  final dynamic error;
  const MeetingDailyError(this.error);
  @override
  List<dynamic> get props => [error];
}