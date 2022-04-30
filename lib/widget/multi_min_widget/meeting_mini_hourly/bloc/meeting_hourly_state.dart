part of 'meeting_hourly_bloc.dart';

abstract class MeetingHourlyState extends Equatable {
  const MeetingHourlyState();
}

class MeetingHourlyInitial extends MeetingHourlyState {
  @override
  List<Object> get props => [];
}
class MeetingHourlyRetrieve extends MeetingHourlyState {
  final List<MeetingModel> result;

  const MeetingHourlyRetrieve(this.result);

  @override
  List<List<MeetingModel>> get props => [result];
}
class MeetingHourlyError extends MeetingHourlyState {
  final dynamic error;
  const MeetingHourlyError(this.error);
  @override
  List<dynamic> get props => [error];
}