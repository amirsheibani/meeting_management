part of 'people_unit_bloc.dart';

abstract class PeopleUnitState extends Equatable {
  const PeopleUnitState();
}

class PeopleUnitInitial extends PeopleUnitState {
  @override
  List<Object> get props => [];
}

class NewPeopleUnitLoadedState extends PeopleUnitState {
  final UnitModel unitModel;
  const NewPeopleUnitLoadedState(this.unitModel);
  @override
  List<Object?> get props => [unitModel];
}
class UpdatePeopleUnitLoadedState extends PeopleUnitState {
  final bool status;
  const UpdatePeopleUnitLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeletePeopleUnitLoadedState extends PeopleUnitState {
  final bool status;
  const DeletePeopleUnitLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class RetrievePeopleUnitLoadedState extends PeopleUnitState {
  final List<UnitModel> units;
  const RetrievePeopleUnitLoadedState(this.units);
  @override
  List<Object?> get props => [units];
}
class QueryPeopleUnitLoadedState extends PeopleUnitState {
  final List<UnitModel> units;
  const QueryPeopleUnitLoadedState(this.units);
  @override
  List<Object?> get props => [units];
}
class QueryCountPeopleUnitLoadedState extends PeopleUnitState {
  final List<UnitModel> units;
  const QueryCountPeopleUnitLoadedState(this.units);
  @override
  List<Object?> get props => [units];
}


class PeopleUnitErrorState extends PeopleUnitState {
  final dynamic error;
  const PeopleUnitErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}