part of 'people_bloc.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class AddPeopleEvent extends PeopleEvent {
  final PeopleModel peopleModel;

  const AddPeopleEvent({required this.peopleModel});
  @override
  List<PeopleModel> get props => [peopleModel];
}
class UpdatePeopleEvent extends PeopleEvent {
  final PeopleModel peopleModel;

  const UpdatePeopleEvent({required this.peopleModel});
  @override
  List<PeopleModel> get props => [peopleModel];
}
class DeletePeopleEvent extends PeopleEvent {
  final int id;

  const DeletePeopleEvent({required this.id});
  @override
  List<int> get props => [id];
}

class RetrievePeopleEvent extends PeopleEvent {
  final int? id;
  final String? searchText;

  const RetrievePeopleEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}
class QueryCountPeopleEvent extends PeopleEvent {
  final String? searchText;

  const QueryCountPeopleEvent({this.searchText});
  @override
  List<dynamic> get props => [searchText];
}
class QueryPeopleEvent extends PeopleEvent {
  final String? searchText;
  final int? pageNumber;
  final int? count;

  const QueryPeopleEvent({this.searchText,this.pageNumber, this.count,});
  @override
  List<dynamic> get props => [searchText,count,pageNumber];
}

class ShowPeopleEvent extends PeopleEvent {
  final PeopleModel peopleModel;

  const ShowPeopleEvent(this.peopleModel);
  @override
  List<dynamic> get props => [peopleModel];
}