part of 'set_meeting_bloc.dart';

abstract class SetMeetingState extends Equatable {
  const SetMeetingState();
}

class SetMeetingInitial extends SetMeetingState {
  @override
  List<Object> get props => [];
}
class MeetingAddNew extends SetMeetingState {
  final bool status;

  const MeetingAddNew(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingUpdate extends SetMeetingState {
  final bool status;

  const MeetingUpdate(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingRemove extends SetMeetingState {
  final bool status;

  const MeetingRemove(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingCancel extends SetMeetingState {
  final bool status;

  const MeetingCancel(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingResume extends SetMeetingState {
  final bool status;

  const MeetingResume(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingStart extends SetMeetingState {
  final bool status;

  const MeetingStart(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingComplete extends SetMeetingState {
  final bool status;

  const MeetingComplete(this.status);

  @override
  List<Object> get props => [status];
}
class MeetingError extends SetMeetingState {
  final dynamic error;
  const MeetingError(this.error);
  @override
  List<dynamic> get props => [error];
}