part of 'meeting_pending_bloc.dart';

abstract class MeetingPendingEvent extends Equatable {
  const MeetingPendingEvent();
}
class PendingMeetingEvent extends MeetingPendingEvent {
  final DateTime? fromDate;
  final DateTime? toDate;

  const PendingMeetingEvent({this.fromDate, this.toDate});
  @override
  List<DateTime?> get props => [fromDate,toDate];
}
class UpdatePendingMeetingEvent extends MeetingPendingEvent {
  final MeetingModel meetingModel;

  const UpdatePendingMeetingEvent(this.meetingModel);
  @override
  List<MeetingModel> get props => [meetingModel];
}