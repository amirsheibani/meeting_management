part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();
}

class PersonInitial extends PersonState {
  @override
  List<Object> get props => [];
}

class PersonDataSuccess extends PersonState {
  final bool isUpdate;
  final Person person;
  const PersonDataSuccess(this.isUpdate, this.person);

  @override
  List<Object?> get props => [isUpdate,person];
}

class UpdateUserInformationSuccess extends PersonState {
  const UpdateUserInformationSuccess();

  @override
  List<Object?> get props => [];
}

class PersonDataFailed extends PersonState {
  final Exception exception;

  const PersonDataFailed(this.exception);

  @override
  List<Exception?> get props => [exception];
}

