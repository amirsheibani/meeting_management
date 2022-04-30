part of 'invitees_bloc.dart';

abstract class InviteesState extends Equatable {
  const InviteesState();
}

class InviteesInitial extends InviteesState {
  @override
  List<Object> get props => [];
}
class InviteesRetrieve extends InviteesState {
  final List<InviteesModel> result;

  const InviteesRetrieve(this.result);

  @override
  List<List<InviteesModel>> get props => [result];
}
class InviteesError extends InviteesState {
  final dynamic error;
  const InviteesError(this.error);
  @override
  List<dynamic> get props => [error];
}