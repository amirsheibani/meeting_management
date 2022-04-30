part of 'person_dropdown_bloc.dart';

abstract class PersonDropdownEvent extends Equatable {
  const PersonDropdownEvent();
}
class GetAllPersonEvent extends PersonDropdownEvent {
  const GetAllPersonEvent();

  @override
  List<Object?> get props => [];
}