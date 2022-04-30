part of 'invite_people_bloc.dart';

abstract class InvitePeopleState extends Equatable {
  const InvitePeopleState();
}

class InvitePeopleInitial extends InvitePeopleState {
  @override
  List<Object> get props => [];
}
class MemberInviteLoadedState extends InvitePeopleState {
  final List<Member> items;
  const MemberInviteLoadedState(this.items);
  @override
  List<List<Member>> get props => [items];
}
class MemberRemoveLoadedState extends InvitePeopleState {
  final List<Member> items;
  const MemberRemoveLoadedState(this.items);
  @override
  List<List<Member>> get props => [items];
}
class InvitePeopleDropdownErrorState extends InvitePeopleState {
  final dynamic error;
  const InvitePeopleDropdownErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}