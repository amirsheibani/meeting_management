part of 'people_group_bloc.dart';

abstract class PeopleGroupEvent extends Equatable {
  const PeopleGroupEvent();
}

class AddPeopleGroupEvent extends PeopleGroupEvent {
  final PeopleGroupModel peopleGroupModel;

  const AddPeopleGroupEvent({required this.peopleGroupModel});
  @override
  List<PeopleGroupModel> get props => [peopleGroupModel];
}
class UpdatePeopleGroupEvent extends PeopleGroupEvent {
  final PeopleGroupModel peopleGroupModel;

  const UpdatePeopleGroupEvent({required this.peopleGroupModel});
  @override
  List<PeopleGroupModel> get props => [peopleGroupModel];
}
class DeletePeopleGroupEvent extends PeopleGroupEvent {
  final int id;

  const DeletePeopleGroupEvent({required this.id});
  @override
  List<int> get props => [id];
}
class RetrievePeopleGroupEvent extends PeopleGroupEvent {
  final int? id;
  final String? searchText;

  const RetrievePeopleGroupEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}
class RetrievePeopleGroupTypeEvent extends PeopleGroupEvent {
  final int? id;
  final String? searchText;

  const RetrievePeopleGroupTypeEvent({this.id = 48,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}


class ShowPeopleGroupEvent extends PeopleGroupEvent {
  final PeopleGroupModel peopleGroupModel;

  const ShowPeopleGroupEvent(this.peopleGroupModel);
  @override
  List<dynamic> get props => [peopleGroupModel];
}