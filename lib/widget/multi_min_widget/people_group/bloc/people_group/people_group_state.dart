part of 'people_group_bloc.dart';

abstract class PeopleGroupState extends Equatable {
  const PeopleGroupState();
}

class PeopleGroupInitial extends PeopleGroupState {
  @override
  List<Object> get props => [];
}
class NewPeopleGroupLoadedState extends PeopleGroupState {
  final bool status;
  const NewPeopleGroupLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class UpdatePeopleGroupLoadedState extends PeopleGroupState {
  final bool status;
  const UpdatePeopleGroupLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class DeletePeopleGroupLoadedState extends PeopleGroupState {
  final bool status;
  const DeletePeopleGroupLoadedState(this.status);
  @override
  List<Object?> get props => [status];
}
class RetrievePeopleGroupLoadedState extends PeopleGroupState {
  final List<PeopleGroupModel> peopleGroupModels;
  const RetrievePeopleGroupLoadedState(this.peopleGroupModels);
  @override
  List<List<PeopleGroupModel>?> get props => [peopleGroupModels];
}
class RetrievePeopleGroupTypeLoadedState extends PeopleGroupState {
  final List<GroupTypeModel> groupTypeModels;
  const RetrievePeopleGroupTypeLoadedState(this.groupTypeModels);
  @override
  List<List<GroupTypeModel>?> get props => [groupTypeModels];
}

class ShowPeopleGroupLoadedState extends PeopleGroupState {
  final PeopleGroupModel peopleGroupModel;
  const ShowPeopleGroupLoadedState(this.peopleGroupModel);
  @override
  List<Object?> get props => [peopleGroupModel];
}

class PeopleGroupErrorState extends PeopleGroupState {
  final dynamic error;
  const PeopleGroupErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}