part of 'meeting_pending_bloc.dart';

abstract class MeetingPendingState extends Equatable {
  const MeetingPendingState();
}

class MeetingPendingInitial extends MeetingPendingState {
  @override
  List<Object> get props => [];
}

class PendingRetrieve extends MeetingPendingState {
  final List<MeetingModel> result;

  const PendingRetrieve(this.result);

  @override
  List<List<MeetingModel>> get props => [result];
}
class UpdatePendingMeeting extends MeetingPendingState {
  final bool result;

  const UpdatePendingMeeting(this.result);

  @override
  List<bool> get props => [result];
}
class PendingMeetingError extends MeetingPendingState {
  final dynamic error;
  const PendingMeetingError(this.error);
  @override
  List<dynamic> get props => [error];
}