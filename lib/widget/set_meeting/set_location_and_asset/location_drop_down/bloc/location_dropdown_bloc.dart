import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meeting_management/logic/location/model/location_model.dart';
import 'package:meeting_management/logic/location/repository/location_repository.dart';

part 'location_dropdown_event.dart';
part 'location_dropdown_state.dart';

class LocationDropdownBloc extends Bloc<LocationDropdownEvent, LocationDropdownState> {
  final LocationRepository _locationRepository;
  LocationDropdownBloc(this._locationRepository) : super(LocationDropdownInitial()) {
    on<RetrieveLocationDropdownEvent>((event, emit) async {
      try {
        final List<LocationModel> _result = await _locationRepository.retrieveLocation(event.props[0],searchText: event.props[1]);
        emit(RetrieveLocationDropdownLoadedState(_result));
      } catch (exception) {
        emit(LocationDropdownErrorState(exception));
      }
    });
  }
}
