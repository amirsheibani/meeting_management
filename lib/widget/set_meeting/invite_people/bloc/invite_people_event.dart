part of 'invite_people_bloc.dart';

abstract class InvitePeopleEvent extends Equatable {
  const InvitePeopleEvent();
}
class MemberInviteEvent extends InvitePeopleEvent {
  final Member member;
  const MemberInviteEvent(this.member);
  @override
  List<dynamic> get props => [member];
}
class MemberRemoveEvent extends InvitePeopleEvent {
  final Member member;
  const MemberRemoveEvent(this.member);
  @override
  List<dynamic> get props => [member];
}
class GroupMemberInviteEvent extends InvitePeopleEvent {
  final int id;
  const GroupMemberInviteEvent(this.id);
  @override
  List<dynamic> get props => [id];
}