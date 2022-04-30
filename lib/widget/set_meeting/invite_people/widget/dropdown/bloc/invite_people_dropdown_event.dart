part of 'invite_people_dropdown_bloc.dart';

abstract class InvitePeopleDropdownEvent extends Equatable {
  const InvitePeopleDropdownEvent();
}

class RetrievePeoplesDropdownEvent extends InvitePeopleDropdownEvent {

  const RetrievePeoplesDropdownEvent();
  @override
  List<dynamic> get props => [];
}