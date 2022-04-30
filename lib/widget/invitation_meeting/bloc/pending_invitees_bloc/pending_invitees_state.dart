part of 'pending_invitees_bloc.dart';

abstract class PendingInviteesState extends Equatable {
  const PendingInviteesState();
}

class PendingInviteesInitial extends PendingInviteesState {
  @override
  List<Object> get props => [];
}
class PendingInviteesRetrieve extends PendingInviteesState {
  final List<InviteesModel> result;

  const PendingInviteesRetrieve(this.result);

  @override
  List<List<InviteesModel>> get props => [result];
}
class PendingInviteesError extends PendingInviteesState {
  final dynamic error;
  const PendingInviteesError(this.error);
  @override
  List<dynamic> get props => [error];
}