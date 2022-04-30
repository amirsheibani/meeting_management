part of 'invite_people_dropdown_bloc.dart';

abstract class InvitePeopleDropdownState extends Equatable {
  const InvitePeopleDropdownState();
}

class InvitePeopleDropdownInitial extends InvitePeopleDropdownState {
  @override
  List<Object> get props => [];
}
class RetrieveInvitePeopleDropdownLoadedState extends InvitePeopleDropdownState {
  final List<Object> items;
  const RetrieveInvitePeopleDropdownLoadedState(this.items);
  @override
  List<List<Object>> get props => [items];
}

class InvitePeopleDropdownErrorState extends InvitePeopleDropdownState {
  final dynamic error;
  const InvitePeopleDropdownErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}