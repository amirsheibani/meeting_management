part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();
}

class CalendarMeetingEvent extends CalendarEvent {
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? searchText;
  const CalendarMeetingEvent({this.fromDate,this.toDate,this.searchText});
  @override
  List<Object?> get props => [fromDate,toDate,searchText];
}

class CalendarMeetingRemoveEvent extends CalendarEvent {
  final int id;

  const CalendarMeetingRemoveEvent(this.id);
  @override
  List<int> get props => [id];
}