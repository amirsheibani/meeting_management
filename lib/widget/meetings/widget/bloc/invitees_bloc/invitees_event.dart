part of 'invitees_bloc.dart';

abstract class InviteesEvent extends Equatable {
  const InviteesEvent();
}
class InviteesMeetingEvent extends InviteesEvent {
  final int id;
  const InviteesMeetingEvent(this.id);
  @override
  List<int?> get props => [id];
}