part of 'location_dropdown_bloc.dart';

abstract class LocationDropdownState extends Equatable {
  const LocationDropdownState();
}


class LocationDropdownInitial extends LocationDropdownState {
  @override
  List<Object> get props => [];
}

class RetrieveLocationDropdownLoadedState extends LocationDropdownState {
  final List<LocationModel> locations;
  const RetrieveLocationDropdownLoadedState(this.locations);
  @override
  List<List<LocationModel>> get props => [locations];
}

class LocationDropdownErrorState extends LocationDropdownState {
  final dynamic error;
  const LocationDropdownErrorState(this.error);
  @override
  List<dynamic> get props => [error];
}