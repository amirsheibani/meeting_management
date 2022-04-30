part of 'set_meeting_bloc.dart';

abstract class SetMeetingEvent extends Equatable {
  const SetMeetingEvent();
}

class AddNewMeetingEvent extends SetMeetingEvent {
  final MeetingModel meetingModel;

  const AddNewMeetingEvent({required this.meetingModel});
  @override
  List<MeetingModel> get props => [meetingModel];
}
class UpdateMeetingEvent extends SetMeetingEvent {
  final MeetingModel meetingModel;

  const UpdateMeetingEvent({required this.meetingModel});
  @override
  List<MeetingModel> get props => [meetingModel];
}
class RemoveMeetingEvent extends SetMeetingEvent {
  final int id;

  const RemoveMeetingEvent({required this.id});
  @override
  List<int> get props => [id];
}
class CancelMeetingEvent extends SetMeetingEvent {
  final int id;

  const CancelMeetingEvent({required this.id});
  @override
  List<int> get props => [id];
}
class ResumeMeetingEvent extends SetMeetingEvent {
  final int id;

  const ResumeMeetingEvent({required this.id});
  @override
  List<int> get props => [id];
}
class StartMeetingEvent extends SetMeetingEvent {
  final int id;

  const StartMeetingEvent({required this.id});
  @override
  List<int> get props => [id];
}
class CompleteMeetingEvent extends SetMeetingEvent {
  final int id;

  const CompleteMeetingEvent({required this.id});
  @override
  List<int> get props => [id];
}
