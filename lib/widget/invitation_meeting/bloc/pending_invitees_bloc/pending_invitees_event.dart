part of 'pending_invitees_bloc.dart';

abstract class PendingInviteesEvent extends Equatable {
  const PendingInviteesEvent();
}
class InviteesPendingMeetingEvent extends PendingInviteesEvent {
  final int id;
  const InviteesPendingMeetingEvent(this.id);
  @override
  List<int> get props => [id];
}