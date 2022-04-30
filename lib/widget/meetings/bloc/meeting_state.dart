part of 'meeting_bloc.dart';

abstract class MeetingState extends Equatable {
  const MeetingState();
}

class MeetingInitial extends MeetingState {
  @override
  List<Object> get props => [];
}
class MeetingRetrieve extends MeetingState {
  final List<MeetingModel> result;

  const MeetingRetrieve(this.result);

  @override
  List<List<MeetingModel>> get props => [result];
}
class MeetingError extends MeetingState {
  final dynamic error;
  const MeetingError(this.error);
  @override
  List<dynamic> get props => [error];
}