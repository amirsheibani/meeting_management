part of 'person_bloc.dart';

abstract class PersonEvent extends Equatable {
  const PersonEvent();
}

class GetPersonData extends PersonEvent {
  const GetPersonData();

  @override
  List<Object?> get props => [];
}
class UpdateUserInformationEvent extends PersonEvent{
  final Person person;
  const UpdateUserInformationEvent(this.person);

  @override
  List<Object?> get props => [person];
}
class GetUserInformationEvent extends PersonEvent {
  const GetUserInformationEvent();

  @override
  List<Object?> get props => [];
}

