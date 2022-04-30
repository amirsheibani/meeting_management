part of 'person_dropdown_bloc.dart';

abstract class PersonDropdownState extends Equatable {
  const PersonDropdownState();
}

class PersonDropdownInitial extends PersonDropdownState {
  @override
  List<Object> get props => [];
}
class GetAllPersonState extends PersonDropdownState{
  final List<Member> items;

  const GetAllPersonState(this.items);

  @override
  List<List<Member>?> get props => [items];

}

class PersonDropdownErrorState extends PersonDropdownState {
  final dynamic error;
  const PersonDropdownErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}