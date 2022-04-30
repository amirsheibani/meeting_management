part of 'people_bloc.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();
}

class PeopleInitial extends PeopleState {
  @override
  List<Object> get props => [];
}
class NewPeopleLoadedState extends PeopleState {
  final bool status;
  const NewPeopleLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class UpdatePeopleLoadedState extends PeopleState {
  final bool status;
  const UpdatePeopleLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeletePeopleLoadedState extends PeopleState {
  final bool status;
  const DeletePeopleLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}

class RetrievePeopleLoadedState extends PeopleState {
  final List<PeopleModel> peoples;
  const RetrievePeopleLoadedState(this.peoples);
  @override
  List<List<PeopleModel>?> get props => [peoples];
}
class QueryPeopleLoadedState extends PeopleState {
  final List<PeopleModel> peoples;
  const QueryPeopleLoadedState(this.peoples);
  @override
  List<Object?> get props => [peoples];
}
class QueryCountPeopleLoadedState extends PeopleState {
  final List<PeopleModel> peoples;
  const QueryCountPeopleLoadedState(this.peoples);
  @override
  List<Object?> get props => [peoples];
}

class ShowPeopleLoadedState extends PeopleState {
  final PeopleModel peopleModel;
  const ShowPeopleLoadedState(this.peopleModel);
  @override
  List<Object?> get props => [peopleModel];
}

class PeopleErrorState extends PeopleState {
  final dynamic error;
  const PeopleErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}