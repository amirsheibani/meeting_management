part of 'calendar_bloc.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();
}

class CalendarInitial extends CalendarState {
  @override
  List<Object> get props => [];
}

class CalendarRetrieve extends CalendarState {
  final List<MeetingModel> result;

  const CalendarRetrieve(this.result);

  @override
  List<List<MeetingModel>> get props => [result];
}
class CalendarRemoveMeeting extends CalendarState {
  final bool result;

  const CalendarRemoveMeeting(this.result);

  @override
  List<bool> get props => [result];
}
class CalendarError extends CalendarState {
  final dynamic error;
  const CalendarError(this.error);
  @override
  List<dynamic> get props => [error];
}