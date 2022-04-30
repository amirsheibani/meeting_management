part of 'location_dropdown_bloc.dart';

abstract class LocationDropdownEvent extends Equatable {
  const LocationDropdownEvent();
}

class RetrieveLocationDropdownEvent extends LocationDropdownEvent {
  final int? id;
  final String? searchText;

  const RetrieveLocationDropdownEvent({this.id,this.searchText});
  @override
  List<dynamic> get props => [id,searchText];
}