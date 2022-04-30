part of 'people_unit_bloc.dart';

abstract class PeopleUnitEvent extends Equatable {
  const PeopleUnitEvent();
}
class AddUnitEvent extends PeopleUnitEvent {
  final UnitModel unitModel;

  const AddUnitEvent({required this.unitModel});
  @override
  List<UnitModel> get props => [unitModel];
}
class UpdateUnitEvent extends PeopleUnitEvent {
  final UnitModel unitModel;

  const UpdateUnitEvent({required this.unitModel});
  @override
  List<UnitModel> get props => [unitModel];
}
class DeleteUnitEvent extends PeopleUnitEvent {
  final int id;

  const DeleteUnitEvent({required this.id});
  @override
  List<int> get props => [id];
}

class RetrieveUnitEvent extends PeopleUnitEvent {
  final int? id;
  final String? searchText;

  const RetrieveUnitEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}
class QueryCountUnitEvent extends PeopleUnitEvent {
  final String? searchText;

  const QueryCountUnitEvent({this.searchText});
  @override
  List<dynamic> get props => [searchText];
}
class QueryUnitEvent extends PeopleUnitEvent {
  final String? searchText;
  final int? pageNumber;
  final int? count;

  const QueryUnitEvent({this.searchText,this.pageNumber, this.count,});
  @override
  List<dynamic> get props => [searchText,count,pageNumber];
}
